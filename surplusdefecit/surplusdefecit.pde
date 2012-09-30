import org.gicentre.utils.spatial.*;


float rotate_x = 0;
float rotate_y = 0;
int zoom = 0;
int gpsScale = 10000;
int w;
int h;

boolean altitude, hdimetric, argimetric, comsermetric, costconmetric, docsmetric, foodmetric, fuelmetric, goodsmetric, merchmetric = false; 

//SimpleSpreadsheetManager sm;

SimpleSpreadsheetManager sm = new SimpleSpreadsheetManager();

WebMercator proj = new WebMercator();

void setup() {
  //Desktop
  //size(1280, 790, P3D);
  //Projector
  size(1024, 768, P3D);
  frameRate(30);

  sm.init("myProjectName", GoogleLogin, GooglePassword);
  sm.fetchSheetByKey(GoogleDocKey, 0);
  //println(sm.getCellValue("Lat",2));
}

void draw() {
  //rotate_y = rotate_y + 0.1;
  translate(width/2, height/2, zoom);
  background(0);
  rotateY(rotate_y);
  rotateX(rotate_x);

  strokeWeight(10);
  //scale(50);



  //beginShape();
  for (int i=0; i < sm.currentTotalRows -1; i++) {

    //vertex(float(sm.getCellValue("Lat",i)),float(sm.getCellValue("Long",i)),float(sm.getCellValue("Alt",i)));
    //vertex(float(sm.getCellValue("Lat",i)),float(sm.getCellValue("Long",i)));
     stroke(255);
     strokeWeight(10);
 

    
    //text(sm.getCellValue("Capital", i),float(sm.getCellValue("Lat", i))*gpsScale, float(sm.getCellValue("Long", i))*gpsScale, float(sm.getCellValue("Alt", i)));
    //line(float(sm.getCellValue("Lat", i))*gpsScale, float(sm.getCellValue("Long", i))*gpsScale, float(sm.getCellValue("Alt", i)), float(sm.getCellValue("Lat", i+1))*gpsScale, float(sm.getCellValue("Long", i+1))*gpsScale, float(sm.getCellValue("Alt", i+1)));
    
    PVector geo = new PVector(float(sm.getCellValue("Long", i)), float(sm.getCellValue("Lat", i)));
    PVector projCoords = proj.transformCoords(geo);
    
    //println(geo.x+","+geo.y+" -> "+projCoords.x+","+projCoords.y);
    
    PVector nextGeo = new PVector(float(sm.getCellValue("Long", i+1)), float(sm.getCellValue("Lat", i+1)));
    PVector nextProjCoords = proj.transformCoords(nextGeo);
    
    
    //Interconnected
    //text(sm.getCellValue("Capital", i),projCoords.x/gpsScale , projCoords.y/gpsScale, float(sm.getCellValue("Alt", i)));
    //line(projCoords.x/gpsScale , projCoords.y/gpsScale,  float(sm.getCellValue("Alt", i)), nextProjCoords.x/gpsScale , nextProjCoords.y/gpsScale,  float(sm.getCellValue("Alt", i+1)));
    
    int inverse = -1;
    //Bars
    text(sm.getCellValue("Capital", i),projCoords.x/gpsScale , (projCoords.y/gpsScale)*inverse, float(sm.getCellValue("Alt", i)));
    
    
    //boolean altitude, hdimetric, argimetric, comsermetric, comsermetric, docsmetric, foodmetric, fuelmetric, goodsmetric, merchmetric = false; 
    
    //HDIScale  agriMetric  comSerMetric  costPerContainerMetric  docsMetric  foodMetric  fuelMetric  goodsMetric  merchMetric
    
    if (hdimetric == true){ drawLinearDataSet("HDIScale",i,0,projCoords); };
    if (argimetric == true){ drawDataSet("agriMetric",i,0,projCoords); };
    if (comsermetric == true){ drawDataSet("comSerMetric",i,0,projCoords); };
    if (costconmetric == true){ drawDataSet("costPerContainerMetric",i,0,projCoords); };
    if (docsmetric == true){ drawDataSet("docsMetric",i,0,projCoords); };
    if (foodmetric == true){ drawDataSet("foodmetric",i,0,projCoords); };
    if (fuelmetric == true){ drawDataSet("fuelmetric",i,0,projCoords); };
    if (goodsmetric == true){ drawDataSet("goodsmetric",i,0,projCoords); };
    if (merchmetric == true){ drawDataSet("merchMetric",i,0,projCoords); };
    
    
    //Fake Routes
    stroke(0,0,255);
    strokeWeight(5);
    PVector usGeo = new PVector(-77.0241,38.8921);
    PVector usGeoCoords = proj.transformCoords(usGeo);
    line(usGeoCoords.x/gpsScale , (usGeoCoords.y/gpsScale)*inverse,  0, projCoords.x/gpsScale , (projCoords.y/gpsScale)*inverse,  0);
  };


  //endShape();
  //box(40);
}

void keyPressed() {
  if (keyCode == LEFT) {
    rotate_y = rotate_y - 0.01;
  } 
  if (keyCode == RIGHT) {
    rotate_y = rotate_y + 0.01;
  }
  if (keyCode == UP) {
    rotate_x = rotate_x - 0.01;
  }
  if (keyCode == DOWN) {
   rotate_x = rotate_x + 0.01;
  }
  if (key == 'w' || key == 'W') {
      zoom = zoom + 250;
  }
  if (key == 's' || key == 'S') {
      zoom = zoom - 250;
  }
  //options //boolean altitude, hdimetric, argimetric, comsermetric, costconmetric, docsmetric, foodmetric, fuelmetric, goodsmetric, merchmetric = false; 
  if(key == '1'){
   hdimetric = !hdimetric; 
  }
  if(key == '2'){
   argimetric = !argimetric; 
  }
  if(key == '3'){
   comsermetric = !comsermetric; 
  }
  if(key == '4'){
   costconmetric = !costconmetric; 
  }
  if(key == '5'){
   docsmetric = !docsmetric; 
  }
  if(key == '6'){
   foodmetric = !foodmetric; 
  }
  if(key == '7'){
   fuelmetric = !fuelmetric; 
  }
  if(key == '8'){
   goodsmetric = !goodsmetric; 
  }
  if(key == '9'){
   merchmetric = !merchmetric; 
  }
  if(key == '0'){
   altitude = !altitude; 
  }
  
  
}

void drawDataSet(String input, int i,float offset, PVector the_Coords){
  float the_Metric = float(sm.getCellValue(input, i));
  int inverse = -1;
    
    if (the_Metric < 0){
      stroke(255,0,0);
    } else{
      stroke(0,255,0);
    }
    line(the_Coords.x/gpsScale , (the_Coords.y/gpsScale)*inverse,  the_Metric, the_Coords.x/gpsScale , (the_Coords.y/gpsScale)*inverse,  0);
  
};

void drawLinearDataSet(String input, int i,float offset, PVector the_Coords){
  float the_Metric = float(sm.getCellValue(input, i));
  int inverse = -1;
    stroke(255);
    
    line(the_Coords.x/gpsScale , (the_Coords.y/gpsScale)*inverse,  the_Metric, the_Coords.x/gpsScale , (the_Coords.y/gpsScale)*inverse,  0);
  
};
