

class BillNameModel{

   String billName;
   bool bill;

  BillNameModel({required this.billName,required  this.bill});

  BillNameModel.toJson(Map<String,dynamic> parseJson):
    bill = parseJson['Bill'],
    billName = parseJson['BillName'];

}