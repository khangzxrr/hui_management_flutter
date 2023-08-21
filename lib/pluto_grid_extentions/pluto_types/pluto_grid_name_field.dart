import 'package:pluto_grid/pluto_grid.dart';

class PlutoGridNameField extends PlutoColumnTypeText {
  @override
  int compare(a, b) {
    var aSplits = a.split(' ');
    var bSplits = b.split(' ');

    return aSplits.last[0].toString().compareTo(bSplits.last[0].toString());
  }
}
