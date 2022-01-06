// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class FilterState {
  final selectedType = <String>[];
  final selectedSks = <String>[];
  final selectedSemester = <String>[];
  final matkulTypes = [
    CheckboxItem(
      text: 'Wajib UI',
      value: 'Wajib UI',
    ),
    CheckboxItem(
      text: 'Wajib CS',
      value: 'Wajib CS',
    ),
    CheckboxItem(
      text: 'Wajib IS',
      value: 'Wajib IS',
    ),
    CheckboxItem(
      text: 'Wajib Fakultas',
      value: 'Wajib Fakultas',
    ),
    CheckboxItem(
      text: 'Peminatan CS',
      value: 'Peminatan CS',
    ),
    CheckboxItem(
      text: 'Peminatan IS',
      value: 'Peminatan IS',
    ),
  ];

  final sksTotals = [
    CheckboxItem(
      text: '2 SKS',
      value: '2',
    ),
    CheckboxItem(
      text: '3 SKS',
      value: '3',
    ),
    CheckboxItem(
      text: '4 SKS',
      value: '4',
    ),
    CheckboxItem(
      text: '6 SKS',
      value: '6',
    ),
  ];

  final semesterPreconditions = [
    CheckboxItem(
      text: 'Semester 1',
      value: '1',
    ),
    CheckboxItem(
      text: 'Semester 2',
      value: '2',
    ),
    CheckboxItem(
      text: 'Semester 3',
      value: '3',
    ),
    CheckboxItem(
      text: 'Semester 4',
      value: '4',
    ),
    CheckboxItem(
      text: 'Semester 5',
      value: '5',
    ),
    CheckboxItem(
      text: 'Semester 6',
      value: '6',
    ),
    CheckboxItem(
      text: 'Semester 7',
      value: '7',
    ),
    CheckboxItem(
      text: 'Semester 8',
      value: '8',
    ),
  ];

  bool get hasFilter =>
      isFilteredType || selectedSemester.isNotEmpty || selectedSks.isNotEmpty;

  bool get isFilteredType => selectedType.isNotEmpty;

  void pickMatkulType(String val) {
    selectedType.add(val);
  }

  void discardMatkulType(String val) {
    selectedType.remove(val);
  }

  void pickSksTotal(String val) {
    selectedSks.add(val);
  }

  void discardSksTotal(String val) {
    selectedSks.remove(val);
  }

  void pickSemesterPrecondition(String val) {
    selectedSemester.add(val);
  }

  void discardSemesterPrecondition(String val) {
    selectedSemester.remove(val);
  }
}
