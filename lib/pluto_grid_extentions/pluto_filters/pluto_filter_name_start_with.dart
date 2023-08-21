import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutoFilterNameStartWith extends PlutoFilterType {
  @override
  String get title => 'Tên bắt đầu bằng';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var baseSplits = base!.split(' ');
        var searchSplits = search!.split(' ');

        if (baseSplits.last[0] == searchSplits.last[0]) {
          return true;
        }

        return false;
      };
}
