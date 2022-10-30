abstract class InterState {}

class CubitIntialStates extends InterState {}

class ShopIntresSuccessStates extends InterState {}

class ShopIntresLoadingState extends InterState {}

class ShopIntresErrorStates extends InterState {
  final String error;
  ShopIntresErrorStates(this.error);
}

class GetSubCatSuccessStates extends InterState {}

class GetSubCatLoadingState extends InterState {}

class GetSubCatErrorStates extends InterState {
  final String error;
  GetSubCatErrorStates(this.error);
}

class GetSubSubCatSuccessStates extends InterState {}

class GetSubSubCatLoadingState extends InterState {}

class GetSubSubCatErrorStates extends InterState {
  final String error;
  GetSubSubCatErrorStates(this.error);
}
