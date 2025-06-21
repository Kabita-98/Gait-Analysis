# Gait-Analysis
## Introduction
Gait analysis is essential for understanding human movement, with applications in medical diagnosis
and sports performance optimization. However, many existing systems require advanced technical
skills, limiting their accessibility. This project aims to create a user-friendly platform for gait data
analysis through a graphical user interface (GUI). The tool allows users to load, preprocess, and
analyze gait data, focusing on features like maximum knee angle and swing phase duration. Key
functionalities include gait event detection and graphical representation of gait cycles, enabling
comparisons across individuals or conditions. This tool provides an accessible solution for healthcare
professionals, sports scientists, and researchers to analyze gait patterns effectively.
## Methodology
The methodology for this project begins with the analysis of a pre-existing dataset, provided in a
zip file, containing knee joint angle measurements during multiple gait cycles. This dataset includes
data for three different conditions, each comprising 20 subjects with 30 steps recorded per subject.
The knee joint angles were captured at a sampling rate of 250 Hz, ensuring a high level of detail for
each gait cycle. This data serves as the foundation for developing and testing the gait analysis tool,
allowing for in-depth analysis of various gait features across different conditions.
## Implementation
Important Note: Run only the app.m file while ensuring all other files remain in the
current folder of MATLAB to open the application.
### Software Architecture
The system is divided into several key components, which are organized in a modular way to ensure
a clear separation of responsibilities and efficient interaction between them. These components are:
#### Loading page:
The Loading Page serves as the initial interface for users to upload the knee angle data file. This
page is specifically designed to accept data exclusively in zip file format, ensuring compatibility
with the system’s processing requirements. Upon selecting and successfully loading the appropriate
zip file, the system transitions seamlessly to the Display Page, where users can begin visualizing and
analyzing the loaded data.
#### Display page:
The Display Page is a central interface that facilitates various data analysis tasks through three
main tabs, each dedicated to specific functionalities:
1. Raw Data Tab: This tab presents the unprocessed knee angle data and includes three sub-
tabs:
• Subject-Wise: Displays the raw knee angle data for individual subjects, allowing for
detailed examination.
• Subject-Wise Mean of 3 Conditions: Shows the average knee angle data for each
subject across three different conditions, providing insights into overall performance.
• Condition-Wise Mean: Plots the average knee angle data across all subjects for each
condition, enabling comparisons between different conditions.
2. Preprocessing Data Tab: This tab offers tools for various data preprocessing options.
Similar to the Raw Data Tab, it also contains three sub-tabs for subject-wise and condition-
wise visualization, ensuring consistency in analysis.

3. Data Analysis Tab: This tab includes tools for detecting gait cycles and analyzing processed
data. It features a comparative chart box for conducting T-tests and ANOVA on maximum
knee angle and stride phase duration across the mean of the three different conditions, facili-
tating comprehensive statistical analysis.
### Core Functional Module:
• Data Input Module: Responsible for loading and reading the knee angle data from the zip file.
• Preprocessing Module: Handles signal processing tasks, such as applying filters to clean and
smooth the raw data.
• Analysis Module: Detects gait cycles, and calculates key gait metrics like the standard devia-
tion and maximum knee angle.
• Visualization Module: Generates and manages plots for visualizing the raw, filtered, and
analyzed data. This module is responsible for creating both subject-wise and condition-wise
plots across different stages of analysis
