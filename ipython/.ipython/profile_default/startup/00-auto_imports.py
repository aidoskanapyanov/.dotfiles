# pipx inject ipython \
# numpy \
# pandas \
# matplotlib \
# seaborn \
# scikit-learn \
# scipy \
# statsmodels \
# jupyter \
# ipykernel \
# plotly \
# altair \
# openpyxl \
# XlsxWriter \
# polars \
# beautifulsoup4 \
# html5lib \
# lxml \
# pypdf \
# openai \
# python-dotenv \
# ipdb \
# markdownify \
# ydata-profiling

# Data manipulation
import altair as alt

# Visualization
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import plotly.express as px

# Alternative DataFrame library
import polars as pl

# Scientific computing & statistics
import scipy as sp
import seaborn as sns

# Machine learning
import sklearn
import statsmodels.api as sm

# Web scraping
from bs4 import BeautifulSoup

# Ftfy
from ftfy import fix_text

# ANSI escape sequences for colors
reset = "\033[0m"
green = "\033[92m"
blue = "\033[94m"
yellow = "\033[93m"
magenta = "\033[95m"

# Print out the imports with colors
print(f"{green}Imported Data Manipulation Libraries:{reset}")
print(f"{blue}import pandas as pd{reset}")
print(f"{blue}import numpy as np{reset}\n")

print(f"{green}Imported Visualization Libraries:{reset}")
print(f"{blue}import matplotlib.pyplot as plt{reset}")
print(f"{blue}import seaborn as sns{reset}")
print(f"{blue}import plotly.express as px{reset}")
print(f"{blue}import altair as alt{reset}\n")

print(f"{green}Imported Scientific Computing & Statistics Libraries:{reset}")
print(f"{blue}import scipy as sp{reset}")
print(f"{blue}import statsmodels.api as sm{reset}\n")

print(f"{green}Imported Machine Learning Library:{reset}")
print(f"{blue}import sklearn{reset}\n")

print(f"{green}Imported Alternative DataFrame Library:{reset}")
print(f"{blue}import polars as pl{reset}\n")

print(f"{green}Imported Web Scraping Library:{reset}")
print(f"{blue}from bs4 import BeautifulSoup{reset}\n")

print(f"{green}Imported ftfy:{reset}")
print(f"{blue}from ftfy import fix_text{reset}\n")

print(f"{yellow}All desired libraries have been imported!{reset}")
