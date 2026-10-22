'传入中文，得到中文内码
Function GetByteCode(ch)
	code = Asc(ch)
	If code < 0 Then
		code = code + 65536
	End if
    GetByteCode = code
End Function