class UserModel {
  String _id , _name , _email , _password ,_image ;
  UserModel(this._name,this._email,this._password,);
  UserModel.all(this._id,this._name,this._email,this._image);
  UserModel.emailpassword(this._email,this._password);
  UserModel.follow(this._id,this._name,this._image);

  UserModel.fromMap(Map<String,dynamic> data){
    this._id = data["id"] ;
    this._name = data["name"] ;
    this._email = data["email"] ;
    this._image = data["image"] ;
  }
  UserModel.followfromMap(Map<String,dynamic> data){
    this._id = data["id"] ;
    this._name = data["name"] ;
    this._image = data["image"] ;
  }
  Map<String,dynamic> toMap() =>{
    "id" : this._id ,
    "name" : this._name ,
    "email" : this._email ,
    "image" : this._image ,
  };
  Map<String,dynamic> followToMap() =>{
    "id" : this._id ,
    "name" : this._name ,
    "image" : this._image ,
  };
  get id => this._id ;
  set setID(value){
    this._id = value ;
  }
  get name => this._name ;
  set setName(value){
    this._name = value ;
  }
  get email => this._email;
  set setEmail(value){
    this._email = value ;
  }
  get password => this._password ;
  set setPassword(value){
    this._password = value ;
  }
  get image => this._image ;
  set setImage(value){
    this._image = value ;
  }
}