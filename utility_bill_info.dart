// electricity_bill :  http://210.56.23.106:888/iescobill/general/03141310406500
//gas_bill : https://www.sngpl.com.pk/web/viewbill?consumer=23331515215&proc=viewbill&contype=NewCon

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

void main() async {
// ---------------------Variables of Elecltricity Bill----------------------
  void electricityBill() async {
    final response = await http.get(
        'http://210.56.23.106:888/iescobill/general/03141310406500'); // Replace link to Change Electricity Output
    var document = parse(response.body);
    var dueDate = (document
        .getElementsByTagName('tbody')[0]
        .children[1]
        .children[6]
        .text);
    var unitsConsumed = (document
        .getElementsByTagName('tbody')[4]
        .children[4]
        .children[4]
        .text);
    var payableAfterDueDate = (document
        .getElementsByTagName('tbody')[8]
        .children[9]
        .children[1]
        .text);
    var payableBeforeDueDate = (document
        .getElementsByTagName('tbody')[8]
        .children[7]
        .children[1]
        .text);
    var homeAddress = (document
        .getElementsByTagName('tbody')[4]
        .children[1]
        .children[0]
        .text);
    String _adj_address() {
      var removeSpaces = homeAddress.replaceAll(RegExp(r'\s+'), '*');
      var newAddress = removeSpaces.replaceAll(RegExp(r'\*'), ' ').substring(1);
      return newAddress;
    }
    //-------------------------END-------------------------------------------

    print('------------------Electricity Bill-------------------\n');
    print(
        'Payable: Rs: ' + payableBeforeDueDate.replaceAll(RegExp(r'\s+'), ''));
    print('Due Date: ' + dueDate.replaceAll(RegExp(r'\s+'), ''));
    print('Units Consumed: ' + unitsConsumed.replaceAll(RegExp(r'\s+'), ''));
    print('Payable After Due Date: Rs: ' +
        payableAfterDueDate.replaceAll(RegExp(r'\s+'), ''));
    print('Address: ' + _adj_address());
    print('-----------------------------------------------------');
  }

  void gasBill() async {
    //------------------------Variables of Gas----------------------------------------
    final response = await http.get(
        'https://www.sngpl.com.pk/web/viewbill?consumer=23331515215&proc=viewbill&contype=NewCon'); //Replace link to change Gas Output
    var document = parse(response.body);
    var payableBeforeDueDate =
        document.getElementsByTagName('tbody')[5].children[2].children[2].text;
    var dueDate =
        document.getElementsByTagName('tbody')[5].children[3].children[2].text;
    var payableAfterDueDate =
        document.getElementsByTagName('tbody')[5].children[4].children[2].text;
    String address() {
      var name = document
          .getElementsByTagName('tbody')[3]
          .children[0]
          .children[2]
          .text;
      var address_line1 = document
          .getElementsByTagName('tbody')[3]
          .children[1]
          .children[2]
          .text;
      var address_line2 = document
          .getElementsByTagName('tbody')[3]
          .children[2]
          .children[2]
          .text;
      return (name + ' ' + address_line1 + ' ' + address_line2);
    }

    print('\n\n------------------------Gas Bill-----------------\n');
    print('Amount : Rs: ' + payableBeforeDueDate);
    print('Due Date: ' + dueDate);
    print('Payable After Due Date: Rs: ' +
        payableAfterDueDate.replaceAll(RegExp(r'\s+'), ''));
    print('Address: ' + address());
    print('----------------------------------------------------\n\n\n');
  }

  gasBill();
  electricityBill();
  await new Future.delayed(const Duration(seconds: 90));
}
