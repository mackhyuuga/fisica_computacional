var x1 = [];

var y1 = [];

var x2 = [];

var y2 = [];

var x3 = [];

var y3 = [];

var i = 0;
var v = 2;
var k = false;
var mx = 600;
var my = 450;
var n = 255;
var numero_de_repetições = 5458;
var diameter = 10;
var track_diameter = diameter / 4;
var opacity = 150;

function setup() {
  createCanvas(1200, 900);
}

function draw() {

  background(250);
  noStroke();

  partícula1(225, 35, 0, 2);
  partícula2(50, 55, 150, 2);
  partícula3(0, 0, 0, 1);


  i = i + v
  if (i > numero_de_repetições) {
    i = 0;
    k = true;
  }
}

function partícula1(a, b, c, d) {
  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- partícula 1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  fill(a, b, c);
  circle(n * x1[i] + mx, -n * y1[i] + my, d * diameter);
  //-=-=-=-=-=-=-=-=-=-=-=-=-= rastro da partícula 1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  fill(a, b, c, opacity);
  if (k) {
    for (j = 0; j < numero_de_repetições; j = j + v) {
      circle(n * x1[j] + mx, -n * y1[j] + my, track_diameter);
    }
  } else {
    for (j = 0; j < i; j = j + v) {
      circle(n * x1[j] + mx, -n * y1[j] + my, track_diameter);
    }
  }
  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
}

function partícula2(a, b, c, d) {
  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- partícula 2 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  fill(a, b, c);
  circle(n * x2[i] + mx, -n * y2[i] + my, d * diameter);
  //-=-=-=-=-=-=-=-=-=-=-=-=-= rastro da partícula 2 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  fill(a, b, c, opacity);
  if (k) {
    for (j = 0; j < numero_de_repetições; j = j + v) {
      circle(n * x2[j] + mx, -n * y2[j] + my, track_diameter);
    }
  } else {
    for (j = 0; j < i; j = j + v) {
      circle(n * x2[j] + mx, -n * y2[j] + my, track_diameter);
    }
  }
  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
}

function partícula3(a, b, c, d) {

  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- partícula 3 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  fill(a, b, c);
  circle(n * x3[i] + mx, -n * y3[i] + my, d * diameter);
  //-=-=-=-=-=-=-=-=-=-=-=-=-= rastro da partícula 3 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  fill(a, b, c, opacity);
  if (k) {
    for (j = 0; j < numero_de_repetições; j = j + v) {
      circle(n * x3[j] + mx, -n * y3[j] + my, track_diameter);
    }
  } else {
    for (j = 0; j < i; j = j + v) {
      circle(n * x3[j] + mx, -n * y3[j] + my, track_diameter);
    }
  }
  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
}