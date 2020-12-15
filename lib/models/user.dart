class User {
  final String uid;
  String username;
  String country;
  String state;
  String bio;

  User({ this.uid, this.username, this.country, this.state, this.bio });

  void setUsername(String username) {
    this.username = username;
  }
  
  void setBio(String bio) {
    this.bio = bio;
  }
} 