pro newmoon, jd, jd_res

; BSD 2-Clause License 
; Copyright (c) 2016, Akito Davis Kawamura
; See https://github.com/aDAVISk/moonphase for detail.

jd_size = size(jd)
jd_len = jd_size[1]

err = 1.0/(3600.0*24.0) ; error in one second
dd=3.0
maxloop=100

jd_res = jd

FOR i=0,jd_len-1 DO BEGIN
  days = [jd[i]-dd, jd[i], jd[i]+dd]
  mphase, days, lums
  if (lums[1] ge 0.7) then begin
;    print, 'Luminosity cutoff'
    dir = -1 
    if (lums[0] gt lums[2]) then begin
      dir = +1
    endif
    days = days + dir * 7
    mphase, days, lums
  endif
;  print, 'Linear conversion'
  FOR j=1,maxloop DO BEGIN
    if (lums[1] lt 0.3) then begin
;      print, 'sucess break at j = ', j
      break
    endif
    inc =  - lums[1]/(lums[2]-lums[0])*2*dd
    if (abs(inc) gt 7) THEN BEGIN
;      print, 'error with inc = ', inc, ' at j = ', j
      break
    endif 
    days = days + inc
    mphase, days, lums
  ENDFOR

;  print, 'Conditional replacement'
  IF (lums[0] le lums[1]) THEN BEGIN
    mphase, days[0]-dd, tmp
    IF (tmp gt lums[1]) THEN BEGIN
      days = days - dd * 0.5*(1+(lums[1]-lums[0])/lums[1])
    ENDIF ELSE BEGIN
      days = days - dd * (1+(lums[1]-tmp)/lums[1])
    ENDELSE
  ENDIF
  IF (lums[2] le lums[1]) THEN BEGIN
    mphase, days[2]+dd, tmp
    IF (tmp gt lums[1]) THEN BEGIN
      days = days + dd * 0.5*(1+(lums[1]-lums[2])/lums[1])
    ENDIF ELSE BEGIN
      days = days + dd * (1+(lums[1]-tmp)/lums[1])
    ENDELSE
  ENDIF
  mphase, days, lums

;  print, 'Bisectional root finding'
  bb= dd
  FOR j=1,maxloop DO BEGIN
    IF (lums[1] eq 0) THEN BEGIN
;      print, 'Zero luminosity break at j = ', j
      break
    ENDIF
    IF ((lums[0] eq lums[1]) AND (lums[1] eq lums[2])) THEN BEGIN
;      print, 'Flat root break at j = ', j
      break
    ENDIF
    if (lums[0] lt lums[2]) THEN BEGIN
      days[1] = days[1] - bb * 0.5
      days[2] = days[2] - bb
      bb = bb * 0.5
    endif else begin
      days[1] = days[1] + bb * 0.5
      days[0] = days[0] + bb
      bb = bb * 0.5
    endelse
    mphase, days, lums
    if (lums[0] lt lums[1]) then begin
      days = days - bb
      mphase, days, lums
    endif else begin
      if (lums[2] lt lums[1]) then begin
        days = days + bb
        mphase, days, lums
      endif
    endelse
    if (bb lt err) then begin
;      print, 'success break with inc = ', bb, ' at j =', j
      break
    endif
  ENDFOR
  if ((lums[0] - lums[1]) * (lums[1]-lums[2]) gt 0) then begin
    print, i, jd[i]
    print, days[0], days[1], days[2]
    print, lums[0],lums[1],lums[2]
    print, lums[0] - lums[1], lums[1]-lums[2]
    print, 'Enter any to continue: '
    foovar = GET_KBRD()
    print, '-----------------------------------------'
  endif
  jd_res[i] = days[1]
ENDFOR

end
