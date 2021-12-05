// Created by Muhamad Fauzi Ridwan on 16/08/21.

part of '_error.dart';

abstract class Decide<T, K> {
  const Decide();
  B fold<B>(B Function(T failure) ifLeft, B Function(K result) ifRight);
  bool isLeft() => fold((_) => true, (_) => false);
  bool isRight() => fold((_) => false, (_) => true);
}

class Left<L, R> extends Decide<L, R> {
  const Left(this._l);
  final L _l;
  L get value => _l;

  @override
  B fold<B>(B Function(L t) ifLeft, B Function(R k) ifRight) => ifLeft(_l);
}

class Right<L, R> extends Decide<L, R> {
  const Right(this._r);
  final R _r;
  R get value => _r;

  @override
  B fold<B>(B Function(L t) ifLeft, B Function(R k) ifRight) => ifRight(_r);
}
