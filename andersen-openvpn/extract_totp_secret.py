import urllib.parse
import base64
from google.protobuf.internal.decoder import _DecodeVarint32

# uvx --with protobuf python extract_totp_secret.py

# 1. PASTE YOUR MIGRATION LINK HERE
migration_url = "secret"

def decode_migration(url):
    # Parse the data query parameter
    parsed_url = urllib.parse.urlparse(url)
    query_params = urllib.parse.parse_qs(parsed_url.query)
    encoded_data = query_params.get("data", [""])[0]

    if not encoded_data:
        print("Error: No data parameter found.")
        return

    # Pad and decode base64
    padded_encoded_data = encoded_data + "=" * ((4 - len(encoded_data) % 4) % 4)
    payload = base64.b64decode(padded_encoded_data)

    print("\n--- EXTRACTED STANDARD OTP LINKS ---\n")

    # Google's protobuf wraps keys in a repetitive list (Field 1)
    # We will slice the binary buffer step-by-step using a lightweight raw stream scanner
    pos = 0
    while pos < len(payload):
        # Read the protobuf field tag and wire type
        tag_and_type, pos = _DecodeVarint32(payload, pos)
        field_number = tag_and_type >> 3
        wire_type = tag_and_type & 0x7

        # Field 1 contains the parameters payload block
        if field_number == 1 and wire_type == 2:
            length, pos = _DecodeVarint32(payload, pos)
            sub_payload = payload[pos:pos+length]
            pos += length
            parse_otp_parameters(sub_payload)
        else:
            # Skip any metadata fields (batch size, version, etc.)
            if wire_type == 0:
                _, pos = _DecodeVarint32(payload, pos)
            elif wire_type == 2:
                length, pos = _DecodeVarint32(payload, pos)
                pos += length

def parse_otp_parameters(buffer):
    secret, name, issuer = b"", "", ""
    pos = 0

    # Internal scan of individual account sub-blocks
    while pos < len(buffer):
        tag, pos = _DecodeVarint32(buffer, pos)
        field = tag >> 3
        length, pos = _DecodeVarint32(buffer, pos)
        val = buffer[pos:pos+length]
        pos += length

        if field == 1:   # Secret Key Bytes
            secret = val
        elif field == 2: # Name / Label String
            name = val.decode('utf-8', errors='ignore')
        elif field == 3: # Issuer String
            issuer = val.decode('utf-8', errors='ignore')

    if secret:
        # Convert raw binary bytes into standard Base32 text strings
        b32_secret = base64.b32encode(secret).decode('utf-8').replace('=', '')

        # Build standard URL query parameters matching your expected format
        safe_name = urllib.parse.quote(name)
        safe_issuer = urllib.parse.quote(issuer if issuer else "Authenticator")

        # Print the standardized string
        print(f"otpauth://totp/{safe_name}?issuer={safe_issuer}&secret={b32_secret}")

if __name__ == "__main__":
    decode_migration(migration_url)
