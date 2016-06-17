//キーボード押すべし！！
//丸の値により、calm値の大きさと円の色を変えている
//ellipseに丸を書いている、

String lines[];

ArrayList<Meme> memes;

void setup(){
  size(1200,600);
  
  //1.データを配列に読み込む
  //CSVファイルを読み込んで、1行ごとに配列linesの要素として読み込む
  lines = loadStrings("meme_sample.csv");  
  
  //2.可変型配列memesにMemeのデータを格納する
  //memesを初期化する。
  memes = new ArrayList<Meme>();
  
  
  for (int i = 1 ; i < lines.length; i++) {
    
    //1行分のデータをセパレータ「,」で区切った配列にする。
    String[] data = split(lines[i], ',');
    
    //memeオブジェクトを作成
    Meme meme = new Meme();
    
    meme.user_id = data[0];
    meme.zone_date = data[1];
    meme.zone_focus = float(data[2]);
    meme.zone_calm = float(data[3]);
    meme.zone_posture = float(data[4]);
    
    //memeオブジェクトを可変型配列memesに追加
    memes.add(meme);
    
  }
  
}


void draw(){
  background(0);
  
  for(int i = 0; i<memes.size(); i++){
    //memes配列からひとつのmemeを取り出す
    Meme meme = memes.get(i);
    println(meme.user_id + ":" + meme.zone_focus);
  }
  

  //4. 最大値と最小値を調べる
  //zone_focusとzone_calmについてそれぞれ調べる
  float[] values_focus = new float[memes.size()];
  float[] values_calm = new float[memes.size()];
  float[] values_posture = new float[memes.size()];
  float max_focus = 0;
  float min_focus = 0;
  float max_calm = 0;
  float min_calm = 0;
  float max_posture = 0;
  float min_posture = 0;
  for(int i = 0; i<memes.size(); i++){
    Meme meme = memes.get(i);
    values_focus[i] = meme.zone_focus;
    values_calm[i] = meme.zone_calm;
    values_posture[i] = meme.zone_posture;
    max_focus = max(values_focus);
    min_focus = min(values_focus);
    max_calm = max(values_calm);
    min_calm = min(values_calm);
    max_posture = max(values_posture);
    min_posture = min(values_posture);
  }

  //5.点とひとつ前の点を結んで折れ線グラフにしてみる。
  strokeWeight(3);
  stroke(200,220,225);
  float Xaxis_y = height-50;
  float Xaxis_x = 50;
  float step = 8;
  
  float point_x = 0;
  float point_y = 0;
  float point_y1 = 0;
  float point_y2 = 0;
  
  //ひとつまえ点の座標
  float last_point_x = -9999;
  float last_point_y = -9999;
  float last_point_y1 = -9999;
  float last_point_y2 = -9999;
  
  for(int i = 0; i<memes.size(); i++){
    Meme meme = memes.get(i);
    
    //点のx座標の計算
    point_x = Xaxis_x + step * i;
    
    //点のy座標の計算
    point_y = map(meme.zone_focus, min_focus, max_focus, 0, 400);
    point_y = Xaxis_y - point_y;
    point_y1 = map(meme.zone_calm, min_calm, max_calm, 0, 400);
    point_y1 = Xaxis_y - point_y1;
    point_y2 = map(meme.zone_posture, min_posture, max_posture, 0, 400);
    point_y2 = Xaxis_y - point_y2;
    
    
    noStroke();
    float R = map(meme.zone_focus, min_focus, max_focus, 0, 255);
    float G = map(meme.zone_calm, min_calm, max_calm, 0, 255);
    float B = map(meme.zone_posture, min_posture, max_posture, 0, 255);
    fill(R, G, B);
    rect(point_x, 0, step, 30); 
  
  
    strokeWeight(3);
    noFill();
    stroke(255, 0, 0);
    if(last_point_x > -9999){
      strokeWeight(3);
      line(last_point_x, last_point_y, point_x, point_y);
    }
    stroke(0, 255, 0);
    if(last_point_x > -9999){
      strokeWeight(3);
      line(last_point_x, last_point_y1, point_x, point_y1);
    }
    stroke(0, 0, 255);
    if(last_point_x > -9999){
      strokeWeight(3);
      line(last_point_x, last_point_y2, point_x, point_y2);
    }
    
    last_point_x = point_x;
    last_point_y = point_y;
    last_point_y1 = point_y1;
    last_point_y2 = point_y2;
    
  }
  strokeWeight(1);
  stroke(255, 255, 255); 
  line(Xaxis_x,Xaxis_y ,width-50, Xaxis_y);
  line(50,50,Xaxis_x,Xaxis_y);
  
  
}


class Meme {
  String user_id;
  String zone_date;
  float zone_focus;
  float zone_calm;
  float zone_posture;
  String create_date;
  String update_date;
  
  Meme(){}
}