// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class FilterState {
  final selectedType = <String>[];
  final matkulType = [
    CheckboxItem(
      text: 'Wajib UI',
      value: 'wajibui',
    ),
    CheckboxItem(
      text: 'Wajib IK',
      value: 'wajibik',
    ),
    CheckboxItem(
      text: 'Wajib SI',
      value: 'wajibsi',
    ),
    CheckboxItem(
      text: 'Wajib Fakultas',
      value: 'wajibfakultas',
    ),
    CheckboxItem(
      text: 'Peminatan IK',
      value: 'peminatanik',
    ),
    CheckboxItem(
      text: 'Peminatan SI',
      value: 'peminatansi',
    ),
  ];

  void pickMatkulType(String val) {
    selectedType.add(val);
  }

  void discardMatkulType(String val) {
    selectedType.remove(val);
  }
}
