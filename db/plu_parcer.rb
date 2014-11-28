# In this example the model MyFile has_attached_file :attachment
def parce_plu_excel
  Spreadsheet.client_encoding = 'UTF-8'
  @workbook = Spreadsheet.open("db/fixtures/plu_spreadsheet.xls")

  # Get the first worksheet in the Excel file
  @worksheet = @workbook.worksheet(0)

  # It can be a little tricky looping through the rows since the variable
  # @worksheet.rows often seem to be empty, but this will work:
  0.upto @worksheet.last_row_index do |index|
    # .row(index) will return the row which is a subclass of Array
    row = @worksheet.row(index)

    @produce = ProduceByPlu.new
    #row[0] is the first cell in the current row, row[1] is the second cell, etc...
    @produce.plu_number = row[0]
    @produce.commodity = row[1].downcase
    @produce.variety = row[2].downcase if row[2]
    @produce.size = row[3].downcase if row[3]

    @produce.save
  end
end