* CISC 4900 Project "Facial landmarks"

The goal of this project is to assess th reliability of face landmarks
placed on face pictures by research assistants in my lab.

For each landmark, we want to calculate the standard deviation in X
and Y positions, as well as the number of missing values. We want to
produce a table with four columns:

| PointNumber | sdX | sdY | Missing |
|-------------+-----+-----+---------|
| ...         |     |     |         |

Where PointNumber is an identifier for each landmark (see below), sdX
would be the standard deviation of X values for that landmark, sdY the
standard deviation of Y values, and Missing the number of missing
observations. 

At a later stage, we may also want to see whether sdX, sdY, and
Missing differ by race/ethnicity and sex of the face, but we don't
bother with this for now.

* Description of materials

The Measurements/ folder contains examples of face landmarks
files. There are three faces rated by four people each, for a total of
12 files. These are Excel spreadsheet with the following columns:

- PointNumber: A progressive identifier for each facial landmark

- FaceSide: Whether this landmark is on the left, center, or right of
  th face (can be ignored for our purposes)

- X: X position of the landmark

- Y: Y position of the landmark

- Face: An identifier for the face

- Coder: The person who placed the landmarks

- Description: A brief description of the landmark

Alongside this README, there a PDF file with an example of face on
which landmarks have been placed by three coders, just as an example.

* Tips

1. R represents missing values with the special symbol NA. The number
   of missing values in an array x is sum( is.na(x) ), where is.na()
   is a function that tests whether a value is missing. When R loads
   an Excel spreadhseet, NA is automatically assigned to empty cells
   of the spreadsheet

2. The sd() function that calculates standard deviations has an
   argument na.rm. If you pass na.rm=TRUE, missing values are ignored
   when calculating the standard deviation. Otherwise, if one or more
   values are missing, the standard deviation will also be NA, which
   is not helpful.

3. Excel files can be read easily by installing the package readxl,
   with install.packages("readxl"). The function is called
   read_excel. It takes a number of arguments but you only need to
   provide the filename in our case.
