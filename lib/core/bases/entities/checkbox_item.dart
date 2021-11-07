// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_entities.dart';

/// Describing dart UI Entrypoint per section

class CheckboxItem {
  CheckboxItem({
    this.text,
    this.value,
  }) {
    value ??= text;
  }

  String? text;
  String? value;
}
