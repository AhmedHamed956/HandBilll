import 'links.dart';

class Meta {
  int? _currentPage;
  int? _from;
  int? _lastPage;
  List<Links>? _links;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  int? get from => _from;
  int? get lastPage => _lastPage;
  List<Links>? get links => _links;
  String? get path => _path;
  int? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  Meta({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Links>? links,
    String? path,
    int? perPage,
    int? to,
    int? total}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    _from = json["from"];
    _lastPage = json["last_page"];
    if (json["links"] != null) {
      _links = [];
      json["links"].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json["path"];
    _perPage = json["per_page"];
    _to = json["to"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = _currentPage;
    map["from"] = _from;
    map["last_page"] = _lastPage;
    if (_links != null) {
      map["links"] = _links?.map((v) => v.toJson()).toList();
    }
    map["path"] = _path;
    map["per_page"] = _perPage;
    map["to"] = _to;
    map["total"] = _total;
    return map;
  }

}