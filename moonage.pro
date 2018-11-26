pro moonage, jd, age

; BSD 2-Clause License 
; Copyright (c) 2016, Akito Davis Kawamura
; See https://github.com/aDAVISk/moonphase for detail.

jd_size = size(jd)
jd_len = jd_size[1]

err = 1.0/(3600.0*24.0) ; error in one second
dd=1.0
maxloop=100

newmoons = make_array(jd_len,2,/DOUBLE, VALUE=0.0)
jd2 = jd
newmoon, jd, tmp
id = make_array(jd_len, /INTEGER)
FOR i=0,jd_len-1 DO BEGIN
  IF (tmp[i] le jd[i]) THEN BEGIN
    newmoons[i,0] = tmp[i]
    jd2[i] = jd[i] + 28
    id[i] = 1
  ENDIF ELSE BEGIN 
    newmoons[i,1] = tmp[i]
    jd2[i] = jd[i] - 28
    id[i] = 0
  ENDELSE
ENDFOR
newmoon, jd2, tmp
FOR i = 0, jd_len-1 DO BEGIN
  newmoons[i,id[i]] = tmp[i]
ENDFOR
  age = (jd-newmoons[*,0])/(newmoons[*,1]-newmoons[*,0])
end
