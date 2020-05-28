import processing.sound.*;

FFT fft;
AudioIn input;

// Define how many FFT bands to use (this needs to be a power of two)
int bands = 128;

float smoothingFactor = 0.3;

// Create a vector to store the smoothed spectrum data in
float[] sum = new float[bands];

// Variables for drawing the spectrum:
// Declare a scaling factor for adjusting the height of the rectangles
int scale = 7;
// Declare a drawing variable for calculating the width
float barWidth;

//float flying = 0;
//float [][] terrain;

public void setup() {
  size(1280, 720);
  background(255);
  frameRate(20);

  // Calculate the width of the rects depending on how many bands we have
  barWidth = width/float(bands);
  
  input = new AudioIn(this, 0);
  input.start();
  
  // Create the FFT analyzer and connect the playing soundfile to it.
  fft = new FFT(this, bands);
  fft.input(input);
  
  //terrain = new float [bands][height];
}

public void draw() {
  // Set background color, noStroke and fill color
  background(0);
    fill(255, 0, 0);
  noStroke();

  // Perform the analysis
  fft.analyze();

  for (int i = 0; i < bands; i++) {
    // Smooth the FFT spectrum data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
    
    // Draw the rectangles, adjust their height using the scale factor
    noStroke();
    if (-3 <= -sum[i]*height*scale){
      fill(255, 255, 255);
    }else if (-6 < -sum[i]*height*scale && -sum[i]*height*scale < -3){
      fill(249, 53, 255);
    }else if (-10 < -sum[i]*height*scale && -sum[i]*height*scale < -6){
      fill(255, 255, 0);
    }else if (-30 < -sum[i]*height*scale && -sum[i]*height*scale < -10){
      fill(0, 0, 255);
    }else if (-37 < -sum[i]*height*scale && -sum[i]*height*scale < -30){
      fill(34, 255, 0, 140);
    }else{
      fill(255, 0, 0, 140);
    }      
    ellipse((random(width)*smoothingFactor)+12, random(height), barWidth, -sum[i]*height*scale);
    ellipse((random(width)*smoothingFactor)+442, random(height), barWidth, -sum[i]*height*scale);
    ellipse((random(width)*smoothingFactor)+883, random(height), barWidth, -sum[i]*height*scale);
    println(-sum[i]*height*scale);
  }
  //flying -= 0.08;
  //for (int y = 0; y < height; y++){
  //  for (int x = 0; x < bands; x++){
  //    terrain[x][y] = map(noise(x*barWidth, height), 0, 1, -100, 100);
  //  }
  //}
}
