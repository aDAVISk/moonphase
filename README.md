# Description and References
This directory contains IDL code to calculate the phase of the moon.<br>
This IDL code is used for my paper, Kawamura+(2016, http://adsabs.harvard.edu/abs/2016PASJ..tmp...83K)<br>
This code is relied on the IDL Astronomy User's Library of NASA (https://idlastro.gsfc.nasa.gov/) which is based onMeeus, J. (1998, http://adsabs.harvard.edu/abs/2016PASJ..tmp...83K)<br>
<br>
For any publication with the usage of this IDL code, refering to Kawamura+(2016) as well as The IDL Astronomy User's Library of NASA and Meeus, J. (1998) is highly appreciated.<br>
<br>
# How to Use
1) Go to the IDL Astronomy User's Library of NASA (https://idlastro.gsfc.nasa.gov/) and clone the codes to your directory.<br>
2) Clone the code under this directory to where the code from step 1 is available.
3) IN IDL run the code as `moonage, jdlist, phases`, where `jdlist` is 1D array of float/double of Julian days of your interest and `phases` stores the returned values of normalized phase of the moon (0.0=new moon, 1.0=next new moon).

## Exmple
With a csv file of listed Julian days, "example.csv", calculate the normalized phase of the moon and save to "result.csv".
```
IDL> jdcsv = read_csv('example.csv", TYPEs="DOUBLE")
IDL> moonage, jdcsv.FIELD1, phases
IDL> write_csv, 'result.csv', phases
```
