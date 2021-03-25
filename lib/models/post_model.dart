class PostModel {
  String _postId, _content, _ownerId;
  int _likes;
  List<dynamic> _isLike = [];
  List<dynamic> _isFollow = []; // the best solution is change bool to list of string 
  String _date;
  PostModel(
    this._postId,
    this._content,
    this._ownerId,
    this._likes,
    this._isFollow,
    this._isLike,
    this._date,
  );

  PostModel.fromMap(Map<String,dynamic> data){
    this._postId = data["postId"];
    this._content = data["content"];
    this._ownerId = data["ownerId"];
    this._likes = data["likes"];
    this._isLike = data["isLike"];
    this._isFollow = data["isFollow"];
    this._date = data["date"];
  }

  Map<String,dynamic> toMap() => {
    "postId":this._postId ,
    "content" : this._content ,
    "ownerId" : this._ownerId,
    "likes" : this._likes,
    "isLike" : this._isLike,
    "isFollow" : this._isFollow,
    "date" :this._date,
  };

  get postId => this._postId;
  set setPostId(value) {
    this._postId = value;
  }

  get content => this._content;
  set setContent(value) {
    this._content = value;
  }

  get ownerId => this._ownerId;
  set setOwnerId(value) {
    this._ownerId = value;
  }

  get likes => this._likes;
  set setLikes(value) {
    this._likes = value;
  }

  get isFollow => this._isFollow;
  set setIsFollow(value) {
    this._isFollow = value;
  }

  get isLike => this._isLike;
  set setIsLike(value) {
    this._isLike = value;
  }

  get date => this._date;
  set setDate(value) {
    this._date = value;
  }
}
