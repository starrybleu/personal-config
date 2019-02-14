Sub Find_All()
Dim FindRange As Range, c As Range
Dim OutColumn As String, x As Long
'Column Where we put the data, change to suit
OutColumn = "GX"
x = 1
For Each c In ActiveSheet.UsedRange
If c.Interior.Color = RGB(255, 0, 0) Then
         If FindRange Is Nothing Then
                 Set FindRange = c
         Else
                 Set FindRange = Union(FindRange, c)
         End If
End If
Next

If Not FindRange Is Nothing Then
     For Each c In FindRange
      Cells(x, OutColumn) = c.Address
      Cells(x, OutColumn).Offset(, 1) = c.Value
      x = x + 1
    Next
End If

 End Sub
