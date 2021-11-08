// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class FilterState {
  final selectedType = <String>[];
  final selectedSks = <String>[];
  final selectedSemester = <String>[];
  final matkulTypes = [
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

  final sksTotals = [
    CheckboxItem(
      text: '2 SKS',
      value: '2sks',
    ),
    CheckboxItem(
      text: '3 SKS',
      value: '3sks',
    ),
    CheckboxItem(
      text: '4 SKS',
      value: '4sks',
    ),
    CheckboxItem(
      text: '6 SKS',
      value: '6sks',
    ),
  ];

  final semesterPreconditions = [
    CheckboxItem(
      text: 'Semester 1',
      value: 'semester1',
    ),
    CheckboxItem(
      text: 'Semester 2',
      value: 'semester2',
    ),
    CheckboxItem(
      text: 'Semester 3',
      value: 'semester3',
    ),
    CheckboxItem(
      text: 'Semester 4',
      value: 'semester4',
    ),
    CheckboxItem(
      text: 'Semester 5',
      value: 'semester5',
    ),
    CheckboxItem(
      text: 'Semester 6',
      value: 'semester6',
    ),
    CheckboxItem(
      text: 'Semester 7',
      value: 'semester7',
    ),
    CheckboxItem(
      text: 'Semester 8',
      value: 'semester8',
    ),
  ];

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
