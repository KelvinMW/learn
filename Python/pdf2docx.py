from pdf2docx import Converter

#file to Converter
pdf_file = input('enter full path to file :')

#prepare file name
docx_file = 'output.docx'


#convert
cv = Converter(pdf_file)
cv.convert(docx_file)

#end
cv.close()