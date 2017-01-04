/* Monica Rizzolli 004_2015_LOS ANGELES (2015) pde 1280X800 pixels
 
 Acknowledments
 Ivan Korkischko
 Daniel Shiffman, Flocking code
 Anthony Carfello, MAK Center LA
 */

import processing.pdf.*;

// IMAGENS
PImage palm, palm2, veg, veg1, veg2, veg3, veg4, veg5, 
veg6, veg7, veg8, veg9, veg10, veg11, veg12, veg13, veg14, 
veg15;


// GLOBAIS
boolean onoff; // crossing signal
int m = 54;
float semaforo = (random (200, 350));
int tra;
float po = 255; // poor
float fa = 205; // fair
float go = 155; // good
float vg = 105; // very good
float ex = 55; // excellent
int cont; // contador de terremotos
int quake; // ciclo de terremotos
color cor = color (255, 0);

// GLOBAIS PERSON
float bodyx, bodyy, bodyd;

// ARRAYS
Rua [] r = new Rua [10];
Topo [] t = new Topo [14];
TopoB [] tB = new TopoB [5];
Loco [] l = new Loco [21];
Space [] s = new Space [3];
Spacesemi [] semi = new Spacesemi [7];
Land [] land = new Land [5];
Signal [] signal = new Signal [6];
Wait [] wait = new Wait [5];
Janela [] janela = new Janela [46];
ArrayList chuvaSet = new ArrayList ();
ArrayList carSet = new ArrayList();
ArrayList carBSet = new ArrayList();
ArrayList carCSet = new ArrayList();
ArrayList carDSet = new ArrayList();
Flock flock;
Body [] body = new Body [1];

void setup () {

  size (1280, 800);
  textFont(createFont("Arial", 12));
  quake = int (random (3000, 4500));
  cont ++;

  // CARS

  for (int i=0; i< random (5, 20); i++) {
    carSet.add(new Car(-100, 430+m, random(1.5, 4.5), random (18, 28), 10, 255));
  }

  for (int i=0; i< random (5, 20); i++) {
    carBSet.add(new CarB(-100, 421+m, random(-4.5, -1.5), random (15, 29), 10, 255));
  }

  for (int i=0; i< random (15, 30); i++) {
    carCSet.add(new CarC(1065+m, -100, random(-4.5, -2.5), 10, random (15, 29), 255));
  }

  for (int i=0; i< random (25, 35); i++) {
    carDSet.add(new CarD(1056+m, random (-300, -100), random(2.5, 4.5), 10, random (15, 29), 255));
  }

  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < random (20, 50); i++) {
    flock.addBoid(new Boid(1000, random (0, 230)));
  }

  //CHUVA
  for (int i=0; i< random (10000, 30000); i++) {
    chuvaSet.add(new Chuva ((int)random (0, 1280), (int)random (-815, -15)));
  }

  //RUAS
  r [0] = new Rua (1055, -m, 20, height); // Wilshire
  r [1] = new Rua (900, 27, 310, 10); // Wilshire Ridgley
  r [2] = new Rua (900, 138, 310, 10); // Wilshire Burnside
  r [3] = new Rua (900, 251, 310, 10); // Wilshire Dunsmuir
  r [4] = new Rua (-m-20, 420, width+m+20, 20); // Cochran
  r [5] = new Rua (9, 420, 10, 140); // Edgewood
  r [6] = new Rua (351, 251, 10, 309); // Olympics Cochran
  r [7] = new Rua (558, 265, 10, 295); // 9 Cochran
  r [8] = new Rua (768, 251, 10, 309); // 8 Cochran
  r [9] = new Rua (930, 251, 10, 180); // Dunno the name

  //TOPO
  t [0] = new Topo (0, 325, 9, 10, ex, ex, go, ex, ex, vg, go, ex, ex, ex, ex, ex, ex, po, po, go, go, ex); // L1
  t [1] = new Topo (9, 325, 60, 10, ex, ex, go, ex, ex, go, go, ex, ex, ex, ex, ex, ex, po, po, go, go, ex); // L2
  t [2] = new Topo (69, 325, 27, 10, ex, ex, go, vg, ex, ex, go, ex, ex, ex, ex, ex, ex, po, po, po, go, po); // L3
  t [3] = new Topo (96, 325, 54, 10, ex, ex, go, vg, ex, ex, go, vg, ex, ex, ex, ex, ex, po, po, po, ex, po); // L4
  t [4] = new Topo (150, 325, 60, 10, ex, ex, go, po, ex, ex, go, ex, ex, ex, ex, ex, ex, po, po, go, vg, po); // L5
  t [5] = new Topo (210, 325, 98, 10, ex, ex, go, go, ex, ex, go, ex, ex, ex, ex, ex, vg, po, po, go, go, po); // L6
  t [6] = new Topo (308, 325, 25, 10, ex, ex, go, ex, vg, fa, go, fa, ex, ex, ex, ex, ex, po, po, po, po, po); // L7
  t [7] = new Topo (333, 325, 30, 10, vg, go, go, ex, vg, vg, go, vg, ex, fa, ex, ex, ex, po, po, po, po, po); // L8
  t [8] = new Topo (363, 325, 119, 10, vg, go, go, ex, ex, vg, go, ex, ex, fa, ex, ex, ex, po, po, po, po, po); // L9
  t [9] = new Topo (482, 325, 74, 10, ex, ex, go, vg, ex, ex, go, ex, ex, ex, ex, ex, ex, po, po, go, vg, po); // L10
  t [10] = new Topo (556, 325, 98, 10, ex, ex, go, ex, ex, ex, go, ex, ex, ex, ex, ex, ex, po, po, go, go, po); // L11
  t [11] = new Topo (654, 325, 42, 10, ex, ex, go, go, ex, go, go, ex, ex, ex, ex, ex, go, po, po, go, vg, po); // L12
  t [12] = new Topo (695, 325, 73, 10, ex, ex, go, go, ex, go, go, ex, ex, ex, ex, ex, vg, po, po, go, vg, po); // L13
  t [13] = new Topo (768, 325, 114, 10, ex, vg, go, ex, ex, ex, go, ex, ex, fa, ex, ex, ex, po, po, go, fa, po); // L14

  tB [0] = new TopoB (960, 258, 10, 37, ex, go, go, ex, ex, ex, go, ex, vg, fa, ex, ex, ex, go, po, fa, po, go);  // L17
  tB [1] = new TopoB (960, 198, 10, 60, ex, go, go, ex, ex, ex, go, ex, vg, ex, ex, ex, ex, go, po, go, po, go); // L18
  tB [2] = new TopoB (960, 146, 10, 52, ex, go, go, ex, ex, ex, go, ex, vg, fa, ex, ex, ex, go, po, fa, po, go); // L19
  tB [3] = new TopoB (960, 36, 10, 110, ex, go, go, ex, ex, ex, go, ex, vg, fa, ex, ex, ex, go, po, fa, po, go); // L20
  tB [4] = new TopoB (960, 0, 10, 36, ex, ex, go, ex, ex, ex, go, ex, vg, ex, ex, ex, ex, go, po, fa, po, ex); // L21

  //LEGENDAS
  l [0] = new Loco (0, 540, 0, 670, "L1", "0,0");
  l [1] = new Loco (10, 540, 10, 640, "L2", "6,0");
  l [2] = new Loco (68, 505, 68, 610, "L3", "46,0");
  l [3] = new Loco (96, 540, 96, 580, "L4", "64,0");
  l [4] = new Loco (150, 505, 150, 670, "L5", "100,0");
  l [5] = new Loco (210, 475, 210, 640, "L6", "140,0");
  l [6] = new Loco (308, 540, 308, 670, "L7", "205,0");
  l [7] = new Loco (338, 578, 338, 640, "L8", "226,0");
  l [8] = new Loco (362, 540, 362, 610, "L9", "246,0");
  l [9] = new Loco (482, 540, 482, 670, "L10", "321,0");
  l [10] = new Loco (556, 540, 556, 640, "L11", "371,0");
  l [11] = new Loco (654, 345, 654, 670, "L12", "435,0");
  l [12] = new Loco (696, 320, 696, 640, "L13", "463,0");
  l [13] = new Loco (766, 325, 766, 610, "L14", "512,0");
  l [14] = new Loco (882, 485, 882, 580, "L15", "588,0");
  l [15] = new Loco (1096, 295, 1096, 670, "L16", "660,0");
  l [16] = new Loco (1168, 250, 800, 250, "L17", "660,66");
  l [17] = new Loco (1168, 198, 800, 198, "L18", "660,106");
  l [18] = new Loco (1168, 146, 800, 146, "L19", "660,141");
  l [19] = new Loco (1168, 36, 800, 36, "L20", "660,215");
  l [20] = new Loco (1168, 0, 800, 0, "L21", "660,238");

  // CLOSED
  s [0] = new Space (-46, 280, 951, 316);
  s [1] = new Space (-46, 544, 952, 560);
  s [2] = new Space (900, -40, 950, 280);

  // OPEN
  semi [0] = new Spacesemi (330, 544, 352, 562); // escola 
  semi [1] = new Spacesemi (774, 0-m-20, 798, 317); // cathedral, chapel, school
  semi [2] = new Spacesemi (840, 544, 952, 562); // parking + shop
  semi [3] = new Spacesemi (1178, 544, width, 654); // staples
  semi [4] = new Spacesemi (1178, -m-20, 1198, 317); // wilshire right
  semi [5] = new Spacesemi (900, -m-20, 952, 251); // wilshire left
  semi [6] = new Spacesemi (924, 251, 952, 317); // wilshire left

  // LANDMARKS
  land [0] = new Land (332, 566, 338, 578, 344, 566, 0); // escola + bus stop
  land [1] = new Land (940, 566, 946, 578, 952, 566, 0); // tall building
  land [2] = new Land (1182, 192, 1194, 198, 1182, 204, 255); // el rey
  land [3] = new Land (1182, -6, 1194, 0, 1182, 6, 255); // destination 
  land [4] = new Land (536, 312, 542, 300, 548, 312, 255); // pipe

  //SIGNAL
  signal [0] = new Signal (341, 410, 6, semaforo, 30, 40);
  signal [1] = new Signal (758, 410, 6, semaforo, 30, 40);
  signal [2] = new Signal (1045, 410, 6, semaforo, 40, 40);
  signal [3] = new Signal (1045, 241, 6, semaforo, 40, 30);
  signal [4] = new Signal (1045, 128, 6, semaforo, 40, 30);
  signal [5] = new Signal (1045, 17, 6, semaforo, 40, 30);

  // WAIT
  wait [0] = new Wait (327, 206, 30, semaforo);
  wait [1] = new Wait (744, 206, 30, semaforo);
  wait [2] = new Wait (876, 206, 30, semaforo);
  wait [3] = new Wait (876, 93, 30, semaforo);
  wait [4] = new Wait (876, -18, 30, semaforo);

  //JANELA
  janela [0] = new Janela (120, 230, 12, 4, 1200);
  janela [1] = new Janela (-20, 250, 10, 4, 650);
  janela [2] = new Janela (143, 237, 10, 8, 450);
  janela [3] = new Janela (110, 236, 8, 3, 1300);
  janela [4] = new Janela (-30, 446+140, 14, 6, 280);
  janela [5] = new Janela (22, 434+140, 8, 5, 150);
  janela [6] = new Janela (-35, 430+140, 14, 5, 500);
  janela [7] = new Janela (108, 434+140, 7, 3, 386);
  janela [8] = new Janela (116, 428+140, 6, 3, 186);
  janela [9] = new Janela (410, 270, 9, 4, 753);
  janela [10] = new Janela (410, 263, 9, 5, 905);
  janela [11] = new Janela (220, 425+140, 10, 6, 801);
  janela [12] = new Janela (290, 432+140, 8, 3, 431);
  janela [13] = new Janela (423, 271, 7, 5, 289);
  janela [14] = new Janela (433, 271, 11, 4, 289);
  janela [15] = new Janela (509, 265, 12, 6, 180);
  janela [16] = new Janela (320-m, 484-m+140, 10, 4, 369);
  janela [17] = new Janela (368-m, 489-m+140, 7, 5, 520);
  janela [18] = new Janela (420-m, 486-m+140, 13, 7, 738);
  janela [19] = new Janela (425-m, 497-m+140, 8, 3, 592);
  janela [20] = new Janela (480-m, 489-m+165, 6, 6, 623);
  janela [21] = new Janela (508-m, 480-m+140, 9, 5, 732);
  janela [22] = new Janela (516-m, 487-m+140, 8, 9, 579);
  janela [23] = new Janela (557-m, 495-m+140, 10, 12, 832);
  janela [24] = new Janela (645-m, 484-m+140, 6, 5, 731);
  janela [25] = new Janela (683-m, 506-m+140, 6, 4, 369);
  janela [26] = new Janela (682-m, 483-m+140, 8, 4, 200);
  janela [27] = new Janela (758-m, 483-m+140, 9, 5, 879);
  janela [28] = new Janela (794-m, 482-m+140, 12, 5, 450);
  janela [29] = new Janela (842-m, 498-m+140, 7, 3, 525);
  janela [30] = new Janela (868-m, 485-m+140, 5, 5, 983);
  janela [31] = new Janela (706-m, 314-m, 10, 4, 369);
  janela [32] = new Janela (710-m, 325-m, 13, 7, 100);
  janela [33] = new Janela (785-m, 324-m, 7, 4, 85);
  janela [34] = new Janela (798-m, 314-m, 9, 3, 259);
  janela [35] = new Janela (895-m, 322-m, 10, 10, 401);  
  janela [36] = new Janela (913-m, 322-m, 13, 7, 900);
  janela [37] = new Janela (927-m, 313-m, 5, 4, 758);
  janela [38] = new Janela (900-m, 277-m, 11, 13, 500);
  janela [39] = new Janela (933-m, 214-m, 3, 8, 405);
  janela [40] = new Janela (916-m, 226-m, 12, 5, 304);
  janela [41] = new Janela (919-m, 105-m, 5, 3, 710);
  janela [42] = new Janela (919-m, 110-m, 5, 15, 710);
  janela [43] = new Janela (869-m, 134-m, 7, 15, 629);
  janela [41] = new Janela (919-m, 105-m, 5, 3, 710);
  janela [42] = new Janela (912-m, 141-m, 15, 7, 561);
  janela [43] = new Janela (913-m, 175-m, 5, 17, 327);
  janela [44] = new Janela (863-m, 161-m, 4, 13, 489);
  janela [45] = new Janela (930-m, 74-m, 4, 8, 109);

  body [0] = new Body ();

  // VEGETACAO
  palm = loadImage("palmeira mak.png");
  palm2 = loadImage("palmeira.png");
  veg = loadImage("palmeira3.png");
  veg1 = loadImage("veg.png");
  veg2 = loadImage("veg2.png");
  veg3 = loadImage("veg3.png");
  veg4 = loadImage("veg4.png");
  veg5 = loadImage("veg5.png");
  veg6 = loadImage("veg6.png");
  veg7 = loadImage("veg7.png");
  veg8 = loadImage("veg8.png");
  veg9 = loadImage("veg9.png");
  veg10 = loadImage("veg10.png");
  veg11 = loadImage("veg11.png");
  veg12 = loadImage("veg12.png");
  veg13 = loadImage("veg13.png");
  veg14 = loadImage("veg14.png");
  veg15 = loadImage("veg15.png");
}

void draw () {

  background (255, 0);
  println (mouseX, mouseY);
  
  // birds
  flock.run();

  for (int i=0; i<s.length; i++) // ESPACOS PRIVADOS
    s[i].plotClosed();

  for (int i=0; i<semi.length; i++) // SEMI PUBLICOS
    semi[i].plotSemi();

  estatico(); // ESTATICO

  for (int i=0; i<t.length; i++) // TOPOGRAFIA
    t[i].plot();
  for (int i=0; i<tB.length; i++) // TOPOGRAFIA
    tB[i].plot();

  node();

  escala();

  for (int i=0; i<l.length; i++) // LOCALIZACOES
    l[i].plot();

  for (int i=0; i<r.length; i++) // RUAS
    r[i].plot2();

  for (int i=0; i<r.length; i++) // CALCADAS
    r[i].plot();

  for (int i=0; i<land.length; i++) // LANDMARKS
    land[i].plot();

  // teste
  //  if (onoff == true) {
  //    text ("WAIT", 60, 60);
  //  }

  casa();
  casas();

  vege();

  texto();

  for (int i=0; i<wait.length; i++) // WAIT BALAO
    wait[i].plot();

  for (int i=0; i<body.length; i++) // BODY
    body[i].body();

  for (int i=0; i<carSet.size (); i++) {
    Car oneCar = (Car)carSet.get(i);
    oneCar.car();
  }

  for (int i=0; i<carBSet.size (); i++) {
    CarB oneCarB = (CarB)carBSet.get(i);
    oneCarB.car();
  }

  for (int i=0; i<carCSet.size (); i++) {
    CarC oneCarC = (CarC)carCSet.get(i);
    oneCarC.car();
  }

  for (int i=0; i<carDSet.size (); i++) {
    CarD oneCarD = (CarD)carDSet.get(i);
    oneCarD.car();
  }

  night();

  for (int i=0; i<carSet.size (); i++) {
    Car oneCar = (Car)carSet.get(i);
    oneCar.farol();
  }

  for (int i=0; i<carBSet.size (); i++) {
    CarB oneCarB = (CarB)carBSet.get(i);
    oneCarB.farol();
  }

  for (int i=0; i<carCSet.size (); i++) {
    CarC oneCarC = (CarC)carCSet.get(i);
    oneCarC.farol();
  }

  for (int i=0; i<carDSet.size (); i++) {
    CarD oneCarD = (CarD)carDSet.get(i);
    oneCarD.farol();
  }


  for (int i=0; i<janela.length; i++) // JANELAS
    janela[i].plot();

  for (int i=0; i<chuvaSet.size (); i++) {  // CHUVA
    Chuva oneChuva = (Chuva)chuvaSet.get(i);
    oneChuva.plot();
    oneChuva.move();
  }

  for (int i=0; i<signal.length; i++) // SEMAFOROS
    signal[i].plot();

  quake();

}

// The Flock (a list of Boid objects)
// Flocking by Daniel Shiffman

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

}

// The Boid class

class Boid {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

    Boid(float x, float y) {
    acceleration = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    location = new PVector(x, y);
    r = 2;
    maxspeed = 1;
    maxforce = 0.03;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    fill(0);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r);
    vertex(-r, r);
    vertex(r, r);
    endShape();
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (location.x < -r-m-6) velocity.x = -velocity.x;
    if (location.y < -r-m+4) velocity.y = -velocity.y;
    if (location.x > 774+m) location.x = -r;
    if (location.y > 280+m) location.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } 
    else {
      return new PVector(0, 0);
    }
  }
}

// CLASS CHUVA

class Chuva {

  int x, y;
  int i, w;

  public Chuva (int xin, int yin) {

    x=xin;
    y=yin;
  }

  void plot () {

    i+= random (1, 3);
    int w= (int) random (4000, 5500);
    strokeWeight(1);

    if (i < 2*w) {
      noStroke ();
    }

    if (i > 2*w) {
      stroke(0);
    }

    if (i>3*w) {
      i=0;
    }

    line (x, y, x, y + (int) random (4, 12));
  }

  void move () {

    y+=2;

    if (y>height) {
      y=0;
    }
  }
} 


void quake () {

  // earthquake
  cont++;
  if (cont > quake) {
    m=54+int(random(-10, 10));
  }
  if (cont > quake+1) {
    m=54;
  }
  if (cont > quake+2) {
    m=54+int(random(-8, 8));
  }
  if (cont > quake+3) {
    m=54;
  }
  if (cont > quake+4) {
    m=54+int(random(-12, 12));
  }
  if (cont > quake+5) {
    m=54;
  }
  if (cont > quake+6) {
    m=54+int(random(-8, 8));
  }
  if (cont > quake+7) {
    m=54;
    cont=0;
  }
}

// SINAL DE TRANSITO

class Signal {
/* x=x axis 
y=y axis
d=dimensao
r=tempo do semanforo
*/
  
  
  float x, y, d, r, x1, y1;
  int i;

  public Signal (float xin, float yin, float din, float rin, float x1in, float y1in) {

    x=xin;
    y=yin;
    d=din;
    r=rin;
    x1=x1in;
    y1=y1in;
  }

  void plot () {

    i++;

    if (i < r) {
      noStroke();
      fill (155, 205, 231);
      ellipse (x+m, y+m, d+1, d+1);
      ellipse (x+m+x1, y+m, d+1, d+1);
      ellipse (x+m, y+m+y1, d+1, d+1);
      ellipse (x+m+x1, y+m+y1, d+1, d+1);
      onoff = true;
//      println("true");
    }

    if (i > r) {
      noStroke();
      fill(255);
      ellipse (x+m, y+m, d, d);
      ellipse (x+m+x1, y+m, d, d);
      ellipse (x+m, y+m+y1, d, d);
      ellipse (x+m+x1, y+m+y1, d, d);
      onoff = false;
//      println("false");

      if (i > 1.5*r) {
        i = 0;
      }
    }
  }
}

// DIA E NOITE

// tra=transparencia, w=tempo do dia e da noite

int i; // incremento, transparencia
int w= (int) random (3000, 3250); // ciclo do dia e noite

void night () {

  i++;

  if ((i > w) && (i < 1.3*w)) {  
    tra++;
  }

  if ((i > 1.3*w) && (i < 2*w)) {
    tra--;
  }

  if (i > 2*w) {
    i = 0;
    tra=0;
  }

  noStroke(); // noite
  fill (0, tra);
  rect (0, 0, width, height);

  for (int i=0; i<323; i+=75) { // postes de luz
    noFill();
    strokeWeight(20);
    stroke (255, tra/10);
    ellipse (i+m, 326+m, 15, 15);
    ellipse (i+m+38, 534+m, 15, 15);
  }

  for (int i=373; i<550; i+=87) {
    ellipse (i+m, 326+m, 15, 15);
  }

  for (int i=373; i<540; i+=87) {
    ellipse (i+m+38, 534+m, 15, 15);
  }

  for (int i=545; i<735; i+=84) {
    ellipse (i+m+38, 534+m, 15, 15);
  }

  ellipse (710+m, 326+m, 15, 15);

  for (int i=752; i<900; i+=43) {
    ellipse (i+m+38, 326+m, 15, 15);
  }

  for (int i=315; i>275; i-=19) {
    ellipse (960+m, i+m, 15, 15);
  }

  for (int i=315; i>275; i-=19) {
    ellipse (1170+m, i+m, 15, 15);
  }

  for (int i=240; i>0; i-=38) {
    ellipse (960+m, i+m, 15, 15);
  }

  for (int i=240; i>0; i-=39) {
    ellipse (1170+m, i+m, 15, 15);
  }
}

// JANELAS

class Janela {

  int x, y, dim1, dim2, w1, tra1, j; // dimensao e ciclo, transparencia

  public Janela (int xin, int yin, int dim1in, int dim2in, int w1in) {
    x=xin;
    y=yin;
    dim1=dim1in;
    dim2=dim2in;
    w1=w1in;
  }

  void plot () {

    j++;

    if ((j > w1) && (j < 3*w1)) {  
      tra1++;
    }

    if ((j > 3*w1) && (j < 6*w1)) {
      tra1--;
    }

    if (j > 6*w1) {
      j = 0;
      tra1=0;
    }

    noStroke();
    fill(255, tra1);
    strokeWeight(1);
//    stroke(0);
    rect (x+m, y+m, dim1, dim2);
  }
}

// ESPACO

class Space { // closed private space

  float x;
  float y;
  float xend;
  float yend;

  public Space (float xin, float yin, float xendin, float yendin) {
    x=xin;
    y=yin;
    xend=xendin;
    yend=yendin;
  }

  void plotClosed () {

    stroke (0);
    strokeWeight(1);

    for (float i=x; i<=xend; i+=2) {
      line (i+m, y+m, i+m, yend+m);
    }
    for (float j=y; j<=yend; j+=2) {
      line (x+m, j+m, xend+m, j+m);
    }
  }
}




class Spacesemi { // semi public space

  float x;
  float y;
  float xend;
  float yend;

  public Spacesemi (float xin, float yin, float xendin, float yendin) {
    x=xin;
    y=yin;
    xend=xendin;
    yend=yendin;
  }
  
  void plotSemi () {

    stroke (0);

    for (float i=x; i<=xend; i+=2) {
      fill(255);
      noStroke();
      rect (i+m, y+m, xend-i, yend-y);
      stroke (0);
      noFill();
      line (i+m, y+m, i+m, yend+m);
    }
  }
}

// LANDMARKS

class Land {

  float x, y, x1, y1, x2, y2, c;

  public Land (float xin, float yin, 
  float x1in, float y1in, 
  float x2in, float y2in, 
  float cin) {

    x=xin;
    y=yin;
    x1=x1in;
    y1=y1in;
    x2=x2in;
    y2=y2in;
    c=cin; // color
  }

  void plot () {

    fill (c);
    noStroke();
    triangle (x+m, y+m, x1+m, y1+m, x2+m, y2+m);
  }
}

// ESTÁTICO
int c = -34; 
int d = 240;
PFont myFont;

void estatico () {

  stroke(0);
  noFill();

  beginShape(); // up
  vertex (m-51, 300+m);
  vertex (m-51, 320+m);
  vertex (955+m, 320+m);
  vertex (955+m, 0);
  endShape();

  beginShape(); // down
  vertex (m-51, 560+m);
  vertex (m-51, 540+m);
  vertex (955+m, 540+m);
  vertex (955+m, height);
  endShape();

  line (1174+m, 0, 1174+m, 320+m);
  line (1174+m, 320+m, width, 320+m);

  beginShape();
  vertex (1174+m, 600+m);
  vertex (1174+m, 540+m);
  vertex (width, 540+m);
  endShape();
}

void texto () {
  fill(0);
  myFont = createFont("arial", 12);
  textFont(myFont);
  text ("S Cochran Ave", m+1095, m+435);

  int i = m+1061;
  int j = m+460;
  pushMatrix();
  translate(i, j);
  rotate(HALF_PI);
  textFont(myFont);
  text ("Wilshire Blvd", 0, 0);
  popMatrix();
}

void casa () { 
  // casa
  fill(255);
  stroke(0);
  beginShape();
  vertex (m+c+8, m+d);
  vertex (m+c+30, m+d);
  vertex (m+c+30, m+d+2);
  vertex (m+c+36, m+d+2);
  vertex (m+c+36, m+d+4);
  vertex (m+c+60, m+d+4);
  vertex (m+c+60, m+d+28);
  vertex (m+c+44, m+d+28);
  vertex (m+c+44, m+d+24);
  vertex (m+c+18, m+d+24);
  vertex (m+c+18, m+d+28);
  vertex (m+c+4, m+d+28);
  vertex (m+c+4, m+d+22);
  vertex (m+c+8, m+d+22);
  vertex (m+c+8, m+d);
  endShape();

  beginShape();
  vertex (m+c+8, m+d+28);
  vertex (m+c+8, m+d+34);
  vertex (m+c+50, m+d+34);
  vertex (m+c+50, m+d+28);
  vertex (m+c+44, m+d+28);
  vertex (m+c+44, m+d+24);
  vertex (m+c+18, m+d+24);
  vertex (m+c+18, m+d+28);
  vertex (m+c+8, m+d+28);
  endShape();

  rect (m+c, m+d+36, 64, 4);
}


int c2x = 583;
int c2y = 560; // casa 2 x e y

int c3x = 218;
int c3y = 560;

int c4x = 390;
int c4y = 560;

void casas () {

  // casa 2
  fill(255);
  stroke(0);
  rect (c2x+m, c2y+m, 60, 40); // base
  rect (c2x+m, c2y+m, 6, 44); // coluna grande
  rect (c2x+54+m, c2y+m, 6, 44); // coluna grande
  rect (c2x+16+m, c2y+22+m, 6, 22); // coluna pequena
  rect (c2x+38+m, c2y+22+m, 6, 22); // coluna pequena
  rect (c2x+16+m, c2y+m, 28, 22); // base das portas
  rect (c2x+16+m, c2y+20+m, 28, 2); // base da sacada
  noStroke();
  fill(0);
  rect (c2x+19+m, c2y+2+m, 4, 16); // portas
  rect (c2x+25+m, c2y+2+m, 4, 16); // portas 
  rect (c2x+32+m, c2y+2+m, 4, 16); // portas
  rect (c2x+38+m, c2y+2+m, 4, 16); // portas
  stroke(0);
  fill(255);
  beginShape(); // telhado
  vertex (c2x+m+22, c2y+m+22);
  vertex (c2x+m+38, c2y+m+22);
  vertex (c2x+m+38, c2y+m+32);
  vertex (c2x+m+33, c2y+m+38);
  vertex (c2x+m+30, c2y+m+44);
  vertex (c2x+m+27, c2y+m+38);
  vertex (c2x+m+22, c2y+m+32);
  vertex (c2x+m+22, c2y+m+22);
  endShape();

  // casa 03, drawing the house
  fill (255);
  stroke(0);

  rect (c3x+m, c3y+m, 60, 24); // base
  beginShape(); // telhado
  vertex (c3x+m, c3y+m+24);
  vertex (c3x+m+60, c3y+m+24);
  vertex (c3x+m+50, c3y+m+34);
  vertex (c3x+m+10, c3y+m+34);
  vertex (c3x+m, c3y+m+24);
  endShape();
  fill(255);
  triangle (c3x+m, c3y+m+24, c3x+m+20, c3y+m+24, c3x+m+10, c3y+m+38); //telhado triangular 
  beginShape(); // corpo central
  vertex (c3x+m+15, c3y+m+16);
  vertex (c3x+m+45, c3y+m+16);
  vertex (c3x+m+45, c3y+m+24);
  vertex (c3x+m+30, c3y+m+38);
  vertex (c3x+m+15, c3y+m+24);
  vertex (c3x+m+15, c3y+m+16);
  endShape();
  rect (c3x+m+15, c3y+m, 30, 16);
  fill(0);
  noStroke();
  rect (c3x+m+27, c3y+m+2, 6, 12); // porta
  rect (c3x+m+25, c3y+m+18, 4, 10); // janela
  rect (c3x+m+31, c3y+m+18, 4, 10); // janela

  // casa 04
  fill(255);
  stroke(0);
  rect (c4x+m, c4y+m, 60, 24); // base
  beginShape(); // telhado
  vertex (c4x+m, c4y+m+24);
  vertex (c4x+m+60, c4y+m+24);
  vertex (c4x+m+46, c4y+m+34);
  vertex (c4x+m+14, c4y+m+34);
  vertex (c4x+m, c4y+m+24);
  endShape();
  beginShape(); // corpo central
  vertex (c4x+m+6, c4y+m+0);
  vertex (c4x+m+17, c4y+m+0);
  vertex (c4x+m+17, c4y+m+24);
  vertex (c4x+m+11.5, c4y+m+30);
  vertex (c4x+m+6, c4y+m+24);
  vertex (c4x+m+6, c4y+m+0);
  endShape();
  beginShape(); // corpo central
  vertex (c4x+m+20, c4y+m);
  vertex (c4x+m+60, c4y+m);
  vertex (c4x+m+60, c4y+m+24);
  vertex (c4x+m+48, c4y+m+38);
  vertex (c4x+m+20, c4y+m+16);
  vertex (c4x+m+20, c4y+m);
  endShape();
  beginShape(); // corpo central
  vertex (c4x+m+20, c4y+m);
  vertex (c4x+m+40, c4y+m);
  vertex (c4x+m+40, c4y+m+16);
  vertex (c4x+m+30, c4y+m+24);
  vertex (c4x+m+20, c4y+m+16);
  vertex (c4x+m+20, c4y+m);
  endShape();
  fill(0);
  noStroke();
  rect (c4x+m+8, c4y+m+2, 7, 12); // janela
  rect (c4x+m+46, c4y+m+2, 7, 18); // janela

  // predio wilshire
  fill(255);
  stroke(0);
  rect (740+m, m, 34, 240);
 for (int i = m+48; i < m+188; i+=19) {
    fill (255);
    rect (747+m, i, 14, 12);
  }
 fill(255); 
  rect (734+m, 100+m, 40, 40);
  rect (740+m, 104+m, 34, 32);
  rect (744+m, 106+m, 30, 28);
  rect (704+m, 106+m, 32, 28);
  rect (714+m, 104+m, 20, 32);
  rect (704+m, 108+m, 10, 24);
  rect (694+m, 112+m, 10, 16);
  rect (689+m, 116+m, 5, 8);
  rect (740+m, m, 34, 40); 
  rect (740+m, m, 34, 20); 
  rect (740+m, m+200, 34, 40); 
  rect (740+m, m+200, 34, 20); 
  rect (764+m, m, 10, 240); 
  for (int i = m+12; i < m+238; i+=38) {
    fill (0);
    rect (770+m, i, 4, 24);
  }
  rect (744+m, m+110, 20, 20);
  fill(255);
  rect (720+m, 108+m, 14, 24);
  
  rect (743+m, m+3, 18, 14); 
  rect (743+m, m+23, 18, 14); 
  rect (743+m, m+203, 18, 14); 
  rect (743+m, m+223, 18, 14); 
  
  // wilshire segundo predio
  rect (915+m, 626+m, 40, 120);
  rect (920+m, 626+m, 15, 5);
  rect (920+m, 636+m, 15, 10);
  rect (920+m, 651+m, 15, 10);
  rect (920+m, 666+m, 15, 10);
  
  rect (930+m, 626+m, 20, 6);
  rect (930+m, 635+m, 20, 12);
  rect (930+m, 650+m, 20, 12);
  rect (930+m, 665+m, 20, 12);
  
  fill(0);
  rect (950+m, 626+m, 5, 120);
  
  fill(255);
  rect (882+m, 680+m, 68, 40);
  rect (872+m, 685+m, 78, 30);
  
  rect (920+m, 724+m, 15, 10);
  rect (920+m, 739+m, 15, 10);
  rect (930+m, 723+m, 20, 12);
  rect (930+m, 738+m, 20, 12);
  
  for (int i = 686+m; i < 715+m; i+=5) {
    fill(0);
    noStroke();
    rect (874+m, i, 76, 3);
  }
  
//  // legenda das cores
//  fill (155,205,231,255);
//  rect (m+790, m-54, 40, 15);
//  myFont = createFont("arial", 10);
//      textFont(myFont);
//      fill(0);
//      text ("POOR", m+15, m+8);
//  
//  fill (155,205,231,205);
//  rect (m, m+10, 10, 10);
//  
//  fill (155,205,231,155);
//  rect (m, m+20, 10, 10);
//  
//  fill (155,205,231,105);
//  rect (m, m+30, 10, 10);
//  
//  fill (155,205,231,55);
//  rect (m, m+40, 10, 10);
//  
}

// LEGENDAS
class Loco {

  float x, y, w, h; // x, y, width, height
  String t; // localizacao em passos
  String s; // tempo de deslocamento

  public Loco (float xin, float yin, float win, 
               float hin, String tin, String sin) {
    x=xin;
    y=yin;
    w=win;
    h=hin;
    t=tin;
    s=sin;
  }
  
  void plot () {
    
    fill (0);
    stroke (0);
    myFont = createFont("arial",12);
    textFont(myFont);
    line (x+m, y+m, w+m, h+m);
    text (t, w+m, h+m+14);
    fill (0);
    text (s, w+m, h+m+28);
  }
}

// PESSOAS

/* problemas:
 como gerar um novo random number em cada novo caminho
 como comparar a rua com a bolinha
 */

class Body {

  float bodyx = m;
  float bodyy = m+276; // body position
  float bodyd = 8; // diameter
  float bodysx, bodysy; // body speed
  int nodeA = (int) random (325+m, 398+m); // turnpoints 1
  int nodeAA = (int) random (462+m, 535+m); // trunpoints 1, talvez x, 450
  int nodeB = (int) random (965+m, 1035+m); // turnpoints 2
  int nodeBB = (int) random (1095+m, 1160+m); // turnpoints 2
  int cansada = (int) random(855+m, 960+m);
  int destination = m; // destination
  float r = random (1); // random
  boolean back; // back home
  int contar, contarB; // contador

  int [] crossArray = { // eixo y
    281+m, 231+m, 168+m, 118+m, 57+m, 07+m
  };
  int cross = crossArray[(int)random(0, 5)];

  int lim1 = 337+m; // limites no eixo x
  int lim2 = 365+m;
  int lim3 = 754+m;
  int lim4 = 782+m;
  int lim5 = 1041+m;
  int lim6 = 1079+m;

  int lim7 = 456+m; // limites no eixo y
  int lim8 = 416+m;
  int lim9 = 273+m;
  int lim10 = 247+m;
  int lim11 = 164+m;
  int lim12 = 134+m;
  int lim13 = 53+m;
  int lim14 = 23+m;

  float x, y, d; 
  int tr; // texto 


  void body() {
    bodyPlot();
    walk();
  }

  void bodyPlot() {

    x = bodyx+8;
    y = bodyy+5;


    // drawing the body
    fill(255);
    stroke(0);
    ellipse (bodyx, bodyy, bodyd, bodyd);

    // to talk I m tired
    if (back==true) {
      if ((bodyx>cansada-500)&&(bodyx<cansada)) {
        tr++;
      }
      if ((bodyx>cansada-530)&&(bodyx<cansada-500)) {
        tr = 255;
      }
      if ((bodyx>m)&&(bodyx<cansada-310)) {
        tr--;
      }
    }
    if (back == false) {
      tr = 0;
    }
    myFont = createFont("arial", 12);
    textFont(myFont);
    fill(0, tr);
    text ("I'M TIRED", x, y);
    
    
    // to draw the signs
    if ((bodyx>m)&&(bodyx<165+m)) {
      int i = 10;
      int j =200;
      fill(255);
      stroke(0);


      beginShape();
      vertex (i+m, j+m);
      vertex (i+67+m, j+m);
      vertex (i+67+m, j+30+m);
      vertex (i+35+m, j+30+m);
      vertex (i+35+m, j+35+m);
      vertex (i+30+m, j+30+m);
      vertex (i+m, j+30+m);
      vertex (i+m, j+m);
      endShape();

      myFont = createFont("arial", 12); // fonte and sign
      textFont(myFont);
      fill(0);
      text ("SECURED", i+5+m, j+15+m);
      text ("BY", i+5+m, j+25+m);
    }

    // to draw the signs
    if ((bodyx>185+m)&&(bodyx<340+m)) {
      int i = 190;
      int j =185;
      fill(255);
      stroke(0);


      beginShape();
      vertex (i+m, j+m);
      vertex (i+60+m, j+m);
      vertex (i+60+m, j+30+m);
      vertex (i+35+m, j+30+m);
      vertex (i+30+m, j+35+m);
      vertex (i+30+m, j+30+m);
      vertex (i+m, j+30+m);
      vertex (i+m, j+m);
      endShape();

      myFont = createFont("arial", 12);
      textFont(myFont);
      fill(0);
      text ("BEWARE", 195+m, 200+m);
      text ("OF DOG", 195+m, 210+m);
    }
    
     if ((bodyx>360+m)&&(bodyx<520+m)) {
      int i = 370;
      int j =150;
      fill(255);
      stroke(0);


      beginShape();
      vertex (i+m, j+m);
      vertex (i+75+m, j+m);
      vertex (i+75+m, j+30+m);
      vertex (i+35+m, j+30+m);
      vertex (i+30+m, j+35+m);
      vertex (i+30+m, j+30+m);
      vertex (i+m, j+30+m);
      vertex (i+m, j+m);
      endShape();

      myFont = createFont("arial", 12);
      textFont(myFont);
      fill(0);
      text ("ARMED", i+5+m, j+15+m);
      text ("RESPONSE", i+5+m, j+25+m);
    }
    
    // to draw the signs
    if ((bodyx>m+540)&&(bodyx<640+m)) {
      int i = 550;
      int j =150;
      fill(255);
      stroke(0);


      beginShape();
      vertex (i+m, j+m);
      vertex (i+95+m, j+m);
      vertex (i+95+m, j+30+m);
      vertex (i+35+m, j+30+m);
      vertex (i+35+m, j+35+m);
      vertex (i+30+m, j+30+m);
      vertex (i+m, j+30+m);
      vertex (i+m, j+m);
      endShape();

      myFont = createFont("arial", 12); // fonte and sign
      textFont(myFont);
      fill(0);
      text ("WARNING", i+5+m, j+15+m);
      text ("MOVING GATE", i+5+m, j+25+m);
    }
    
     // to draw the signs
    if ((bodyx>660+m)&&(bodyx<960+m)) {
      int i = 670;
      int j =195;
      fill(255);
      stroke(0);


      beginShape();
      vertex (i+m, j+m);
      vertex (i+40+m, j+m);
      vertex (i+40+m, j+30+m);
      vertex (i+25+m, j+30+m);
      vertex (i+20+m, j+35+m);
      vertex (i+20+m, j+30+m);
      vertex (i+m, j+30+m);
      vertex (i+m, j+m);
      endShape();

      myFont = createFont("arial", 12);
      textFont(myFont);
      fill(0);
      text ("KEEP", i+5+m, j+15+m);
      text ("OUT", i+5+m, j+25+m);
    }
    
  }

  void walk() {

    bodyy += bodysy;
    bodyx += bodysx;

    bodysy = 1;
    bodysx = 0;

    // start first choice

    if (bodyy > nodeA) { 
      bodysy = 0;
      bodysx = 1;
    }

    // end first choice    

    // start second choice

    if (r < 0.5) {
      if (bodyx > nodeB) {
        bodysy = -1;
        bodysx = 0;
      }
    }

    if (r > 0.5) {
      if (bodyx > nodeBB) {
        bodysy = -1;
        bodysx = 0;
      }
    }

    // end second choice

    // start cross wilshire

    if ((bodyy == cross) && (bodyx < nodeBB)) {
      bodysx = 1;
      bodysy = 0;
    }

    // end cross wilshire

    if (bodyy == destination) {
      bodysy = 0;
      bodysx = 1;
    }

    if ((bodyx==1184+m)&&(bodyy==m)) {
      bodysx = 0;
      bodysy = 0;
      contar ++;
    }

    if ((contar > (int) random (100, 150))&&(bodyx==1184+m)&&(bodyy==m)) {
      back = true;
      contar = 0;
    }

    if (back == true) {
      bodysx = -1;
      bodysy = 0;
    }

    // start back first choice
    if ((r < 0.5) && (back == true)) {
      if (bodyx < nodeB) {
        bodysy = 1;
        bodysx = 0;
      }
    }

    if ((r > 0.5) && (back == true)) {
      if (bodyx < nodeBB) {
        bodysy = 1;
        bodysx = 0;
      }
    }
    // end back first choice

    // start cross wilshire back
    if ((bodyy == cross) && (bodyx < nodeBB) && (back == true)) {
      bodysx = -1;
      bodysy = 0;
    }
    // end cross wilshire back

    if ((bodyx < nodeB) && (bodyy == cross) && (back == true)) {
      bodysx = 0;
      bodysy = 1;
    }

    // start second choice back
    if ((bodyy > nodeA) && (back==true)) { 
      bodysy = 0;
      bodysx = -1;
    }

    if ((bodyx == m) && (back == true)) {
      bodysx = 0;
      bodysy = -1;
    }

    if ((bodyx == m) && (back == true) && (bodyy == 276+m)) {
      bodysx = 0;
      bodysy = 0;
      contarB++;
    }

    if ((contarB > (int) random (300, 350)) && (bodyx == m) && (bodyy == 276+m)) {
      back = false;
      contarB=0;
      bodysy = 1;
      bodysx = 0;
    }

    if (back==false) {
      if ((onoff == true) && (((bodyx>lim1)&&(bodyx<lim1+10))
        || ((bodyx>lim3)&&(bodyx<lim3+10)) || ((bodyx>lim5)&&(bodyx<lim5+10))
        || ((bodyx>960+m)&&(bodyx<1160+m)&&(bodyy<lim7)&&(bodyy>lim7-10)) 
        || ((bodyy<lim9)&&(bodyy>lim9-10))
        || ((bodyy<lim11)&&(bodyy>lim11-10)) || ((bodyy<lim13)&&(bodyy>lim13-10)))) { // WAIT WAIT WAIT
        bodysx = 0;
        bodysy = 0;
      }
    }

    if (back==true) {
      if ((onoff == true) && (((bodyx>lim2)&&(bodyx<lim2+10))
        || ((bodyx>lim4)&&(bodyx<lim4+10)) || ((bodyx>lim6)&&(bodyx<lim6+10))
        || ((bodyx>960+m)&&(bodyx<1160+m)&&(bodyy<lim8)&&(bodyy>lim8-10)) 
        || ((bodyy<lim10)&&(bodyy>lim10-10))
        || ((bodyy<lim12)&&(bodyy>lim12-10)) || ((bodyy<lim14)&&(bodyy>lim14-10)))) { // WAIT WAIT WAIT
        bodysx = 0;
        bodysy = 0;
      }
    }
  }
}

// RUAS E CARROS

class Rua {

  float ruaw, ruah; // x, y, width, height
  float ruax, ruay; // localizacao das ruas

  public Rua (float ruaxin, float ruayin, float ruawin, float ruahin) {
    ruax=ruaxin;
    ruay=ruayin;
    ruaw=ruawin;
    ruah=ruahin;
  }

  void plot () {

    fill (155, 205, 231);
    stroke (155, 205, 231);
    rect (ruax+m, ruay+m, ruaw, ruah);
  }

  void plot2 () {

    fill (255);
    stroke (255);
    rect (ruax+m-5, ruay+m-5, ruaw+10, ruah+10);
  }
}


class Car {

  float carXV;
  float carXD;
  float carYD;
  color carColor;
  float carX;
  float carY;


  public Car (float startX, float startY, float startXV, float startXD, 
  float startYD, color startCarColor) {
    carX = startX;
    carY = startY;
    carXV = startXV;
    carXD = startXD;
    carYD = startYD;
    carColor = startCarColor;
  }

  void car() {

    if (onoff==true) {
      carX += carXV;
    }
    if ((onoff==false)&&(((carX+carXD>-100)&&(carX+carXD<341+m))
      ||((carX+carXD>351+m)&&(carX+carXD<758+m))
      ||((carX+carXD>768+m)&&(carX+carXD<1045+m))
      || ((carX+carXD>1055+m)&&(carX+carXD<width+100)))) {
      carX += carXV;
    }

    noStroke();
    fill(carColor);
    rect (carX, carY, carXD, carYD);
    if (carX > width) {
      carX = -100;
    }
    if (carX < -100) {
      carX = width;
    }
  }
  void farol () { 
    stroke (255, tra/10);
    strokeWeight (10);
    fill(255, tra);
    ellipse (carX+carXD, carY+2, 4, 4);
    ellipse (carX+carXD, carY+8, 4, 4);
  }
}

class CarB {

  float carXV;
  float carXD;
  float carYD;
  color carColor;
  float carX;
  float carY;


  public CarB (float startX, float startY, float startXV, float startXD, 
  float startYD, color startCarColor) {
    carX = startX;
    carY = startY;
    carXV = startXV;
    carXD = startXD;
    carYD = startYD;
    carColor = startCarColor;
  }

  void car() {

    if (onoff==true) {
      carX += carXV;
    }
    if ((onoff==false)&&(((carX>1085+m)&&(carX<width+m))
      ||((carX>788+m)&&(carX<1075+m))
      ||((carX>371+m)&&(carX<778+m))
      || ((carX>-100)&&(carX<361+m)))) {
      carX += carXV;
    }

    noStroke();
    fill(carColor);
    rect (carX, carY, carXD, carYD);
    if (carX > width) {
      carX = -100;
    }
    if (carX < -100) {
      carX = width;
    }
  }
  void farol () { 
    stroke (255, tra/10);
    strokeWeight (10);
    fill(255, tra);
    ellipse (carX, carY+2, 4, 4);
    ellipse (carX, carY+8, 4, 4);
  }
}

class CarC {

  float carYV;
  float carXD;
  float carYD;
  color carColor;
  float carX;
  float carY;


  public CarC (float startX, float startY, float startYV, float startXD, 
  float startYD, color startCarColor) {
    carX = startX;
    carY = startY;
    carYV = startYV;
    carXD = startXD;
    carYD = startYD;
    carColor = startCarColor;
  }

  void car() {

    if (onoff==true) {
      carY += carYV;
    }
    if ((onoff==false)&&(((carY>-100)&&(carY<67+m))
      ||((carY>77+m)&&(carY<178+m))
      ||((carY>188+m)&&(carY<291+m))
      || ((carY>301+m)&&(carY<470+m))
      ||((carY>480+m)&&(carY<height+m)))) {
      carY += carYV;
    }

    noStroke();
    fill(carColor);
    rect (carX, carY, carXD, carYD);
    fill(255, tra);
    ellipse (carX+2, carY, 4, 4);
    ellipse (carX+8, carY, 4, 4);
    if (carY > height) {
      carY = -100;
    }
    if (carY < -100) {
      carY = height;
    }
  }

  void farol () { 
    stroke (255, tra/10);
    strokeWeight (10);
    fill(255, tra);
    ellipse (carX+2, carY, 4, 4);
    ellipse (carX+8, carY, 4, 4);
  }
}


class CarD {

  float carYV;
  float carXD;
  float carYD;
  color carColor;
  float carX;
  float carY;


  public CarD (float startX, float startY, float startYV, float startXD, 
  float startYD, color startCarColor) {
    carX = startX;
    carY = startY;
    carYV = startYV;
    carXD = startXD;
    carYD = startYD;
    carColor = startCarColor;
  }

  void car() {

    if (onoff==true) {
      carY += carYV;
    }
    if ((onoff==false)&&(((carY>-100)&&(carY<m-carYD-13))
      ||((carY>m-carYD-3)&&(carY<98+m-carYD))
      ||((carY>108+m-carYD)&&(carY<221+m-carYD))
      || ((carY>231+m-carYD)&&(carY<285+m-carYD))
      ||((carY>295+m-carYD)&&(carY<height+m)))) {
      carY += carYV;
    }

    noStroke();
    fill(carColor);
    rect (carX, carY, carXD, carYD);
    fill(255, tra);
    ellipse (carX+2, carY, 4, 4);
    ellipse (carX+8, carY, 4, 4);
    if (carY > height) {
      carY = -100;
    }
    if (carY < -100) {
      carY = height;
    }
  }

  void farol () { 
    stroke (255, tra/10);
    strokeWeight (10);
    fill(255, tra);
    ellipse (carX+2, carY+carYD, 4, 4);
    ellipse (carX+8, carY+carYD, 4, 4);
  }
}

// TOPOGRAFIA

class Topo {

  float x, y, w, h, t, t1, t2, t3, t4, t5, t6, t7, t8, t9, 
  t10, t11, t12, t13, t14, t15, t16, t17; // x, y, largura, altura, transparencia

  public Topo (float xin, float yin, float win, 
  float hin, float tin, float t1in, float t2in, 
  float t3in, float t4in, float t5in, float t6in, 
  float t7in, float t8in, float t9in, float t10in, 
  float t11in, float t12in, float t13in, float t14in, 
  float t15in, float t16in, float t17in) {
    x=xin;
    y=yin;
    w=win;
    h=hin;
    t=tin; // transparencia
    t1=t1in;
    t2=t2in;
    t3=t3in;
    t4=t4in;
    t5=t5in;
    t6=t6in;
    t7=t7in;
    t8=t8in;
    t9=t9in;
    t10=t10in;
    t11=t11in;
    t12=t12in;
    t13=t13in;
    t14=t14in;
    t15=t15in;
    t16=t16in;
    t17=t17in;
  }

  void plot () {

    noStroke();
    fill (155, 205, 231, t);
    rect (x+m, y+m, w, h);

    fill (155, 205, 231, t1);
    rect (x+m, y+m+10, w, h);

    fill (155, 205, 231, t2);
    rect (x+m, y+m+20, w, h);

    fill (155, 205, 231, t3);
    rect (x+m, y+m+30, w, h);

    fill (155, 205, 231, t4);
    rect (x+m, y+m+40, w, h);

    fill (155, 205, 231, t5);
    rect (x+m, y+m+50, w, h);

    fill (155, 205, 231, t6);
    rect (x+m, y+m+60, w, h);

    fill (155, 205, 231, t7);
    rect (x+m, y+m+70, w, h);

    fill (155, 205, 231, t8);
    rect (x+m, y+m+80, w, h);

    fill (155, 205, 231, t9);
    rect (x+m, y+m+120, w, h);

    fill (155, 205, 231, t10);
    rect (x+m, y+m+130, w, h);

    fill (155, 205, 231, t11);
    rect (x+m, y+m+140, w, h);

    fill (155, 205, 231, t12);
    rect (x+m, y+m+150, w, h);

    fill (155, 205, 231, t13);
    rect (x+m, y+m+160, w, h);

    fill (155, 205, 231, t14);
    rect (x+m, y+m+170, w, h);

    fill (155, 205, 231, t15);
    rect (x+m, y+m+180, w, h);

    fill (155, 205, 231, t16);
    rect (x+m, y+m+190, w, h);

    fill (155, 205, 231, t17);
    rect (x+m, y+m+200, w, h);
  }
}

class TopoB {

  float x, y, w, h, t, t1, t2, t3, t4, t5, t6, t7, t8, t9, 
  t10, t11, t12, t13, t14, t15, t16, t17; // x, y, largura, altura, transparencia

  public TopoB (float xin, float yin, float win, 
  float hin, float tin, float t1in, float t2in, 
  float t3in, float t4in, float t5in, float t6in, 
  float t7in, float t8in, float t9in, float t10in, 
  float t11in, float t12in, float t13in, float t14in, 
  float t15in, float t16in, float t17in) {
    x=xin;
    y=yin;
    w=win;
    h=hin;
    t=tin; // transparencia
    t1=t1in;
    t2=t2in;
    t3=t3in;
    t4=t4in;
    t5=t5in;
    t6=t6in;
    t7=t7in;
    t8=t8in;
    t9=t9in;
    t10=t10in;
    t11=t11in;
    t12=t12in;
    t13=t13in;
    t14=t14in;
    t15=t15in;
    t16=t16in;
    t17=t17in;
  }

  void plot () {

    noStroke();
    fill (155, 205, 231, t);
    rect (x+m, y+m, w, h);

    fill (155, 205, 231, t1);
    rect (x+m+10, y+m, w, h);

    fill (155, 205, 231, t2);
    rect (x+m+20, y+m, w, h);

    fill (155, 205, 231, t3);
    rect (x+m+30, y+m, w, h);

    fill (155, 205, 231, t4);
    rect (x+m+40, y+m, w, h);

    fill (155, 205, 231, t5);
    rect (x+m+50, y+m, w, h);

    fill (155, 205, 231, t6);
    rect (x+m+60, y+m, w, h);

    fill (155, 205, 231, t7);
    rect (x+m+70, y+m, w, h);

    fill (155, 205, 231, t8);
    rect (x+m+80, y+m, w, h);

    fill (155, 205, 231, t9);
    rect (x+m+120, y+m, w, h);

    fill (155, 205, 231, t10);
    rect (x+m+130, y+m, w, h);

    fill (155, 205, 231, t11);
    rect (x+m+140, y+m, w, h);

    fill (155, 205, 231, t12);
    rect (x+m+150, y+m, w, h);

    fill (155, 205, 231, t13);
    rect (x+m+160, y+m, w, h);

    fill (155, 205, 231, t14);
    rect (x+m+170, y+m, w, h);

    fill (155, 205, 231, t15);
    rect (x+m+180, y+m, w, h);

    fill (155, 205, 231, t16);
    rect (x+m+190, y+m, w, h);

    fill (155, 205, 231, t17);
    rect (x+m+200, y+m, w, h);
  }
}

void node () {

  int x = 882;
  int y = 325;
  //  t [14] = new Topo (882, 325, 216, 10, ex, ex, go, vg, ex, ex, go, ex, ex, ex, ex, ex, ex, po, po, fa, fa, po); // node 

  fill (155, 205, 231, ex); // infra, quanntity
  beginShape();
  vertex (x+m, y+m);
  vertex (x+m+78, y+m);
  vertex (x+m+78, y+m-30);
  vertex (x+m+78+10, y+m-30);
  vertex (x+m+78+10, y+m+10);
  vertex (x+m, y+m+10);
  vertex (x+m, y+m);
  endShape();

  fill (155, 205, 231, go); // car collision
  beginShape();
  vertex (x+m, y+m+10);
  vertex (x+m+88, y+m+10);
  vertex (x+m+88, y+m-30);
  vertex (x+m+88+10, y+m-30);
  vertex (x+m+88+10, y+m+20);
  vertex (x+m, y+m+20);
  vertex (x+m, y+m+10);
  endShape();

  fill (155, 205, 231, go); // light
  beginShape();
  vertex (x+m, y+m+20);
  vertex (x+m+88+10, y+m+20);
  vertex (x+m+88+10, y+m-30);
  vertex (x+m+88+20, y+m-30);
  vertex (x+m+88+20, y+m+30);
  vertex (x+m, y+m+30);
  vertex (x+m, y+m+20);
  endShape();

  fill (155, 205, 231, ex); // way finding devices
  beginShape();
  vertex (x+m, y+m+30);
  vertex (x+m+88+20, y+m+30);
  vertex (x+m+88+20, y+m-30);
  vertex (x+m+88+30, y+m-30);
  vertex (x+m+88+30, y+m+40);
  vertex (x+m, y+m+40);
  vertex (x+m, y+m+30);
  endShape();

  fill (155, 205, 231, ex); // security
  beginShape();
  vertex (x+m, y+m+40);
  vertex (x+m+88+30, y+m+40);
  vertex (x+m+88+30, y+m-30);
  vertex (x+m+88+40, y+m-30);
  vertex (x+m+88+40, y+m+50);
  vertex (x+m, y+m+50);
  vertex (x+m, y+m+40);
  endShape();

  fill (155, 205, 231, ex); // infra quality
  beginShape();
  vertex (x+m, y+m+50);
  vertex (x+m+88+40, y+m+50);
  vertex (x+m+88+40, y+m-30);
  vertex (x+m+88+50, y+m-30);
  vertex (x+m+88+50, y+m+60);
  vertex (x+m, y+m+60);
  vertex (x+m, y+m+50);
  endShape();

  fill (155, 205, 231, go); // sound
  beginShape();
  vertex (x+m, y+m+60);
  vertex (x+m+88+50, y+m+60);
  vertex (x+m+88+50, y+m-30);
  vertex (x+m+88+60, y+m-30);
  vertex (x+m+88+60, y+m+70);
  vertex (x+m, y+m+70);
  vertex (x+m, y+m+60);
  endShape();

  fill (155, 205, 231, ex); // cleanness
  beginShape();
  vertex (x+m, y+m+70);
  vertex (x+m+88+60, y+m+70);
  vertex (x+m+88+60, y+m-30);
  vertex (x+m+88+70, y+m-30);
  vertex (x+m+88+70, y+m+80);
  vertex (x+m, y+m+80);
  vertex (x+m, y+m+70);
  endShape();


  fill (155, 205, 231, vg); // scaled to human
  beginShape();
  vertex (x+m, y+m+80);
  vertex (x+m+88+70, y+m+80);
  vertex (x+m+88+70, y+m-30);
  vertex (x+m+88+80, y+m-30);
  vertex (x+m+88+80, y+m+90);
  vertex (x+m, y+m+90);
  vertex (x+m, y+m+80);
  endShape();

  fill (155, 205, 231, fa); // flow
  beginShape();
  vertex (x+m, y+m+120);
  vertex (x+m+88+110, y+m+120);
  vertex (x+m+88+110, y+m-30);
  vertex (x+m+88+120, y+m-30);
  vertex (x+m+88+120, y+m+130);
  vertex (x+m, y+m+130);
  vertex (x+m, y+m+120);
  endShape();

  fill (155, 205, 231, ex); // legibiliy
  beginShape();
  vertex (x+m, y+m+130);
  vertex (x+m+88+120, y+m+130);
  vertex (x+m+88+120, y+m-30);
  vertex (x+m+88+130, y+m-30);
  vertex (x+m+88+130, y+m+140);
  vertex (x+m, y+m+140);
  vertex (x+m, y+m+130);
  endShape();

  fill (155, 205, 231, ex); // flat
  beginShape();
  vertex (x+m, y+m+140);
  vertex (x+m+88+130, y+m+140);
  vertex (x+m+88+130, y+m-30);
  vertex (x+m+88+140, y+m-30);
  vertex (x+m+88+140, y+m+150);
  vertex (x+m, y+m+150);
  vertex (x+m, y+m+140);
  endShape();

  fill (155, 205, 231, ex); // social interaction
  beginShape();
  vertex (x+m, y+m+150);
  vertex (x+m+88+140, y+m+150);
  vertex (x+m+88+140, y+m-30);
  vertex (x+m+88+150, y+m-30);
  vertex (x+m+88+150, y+m+160);
  vertex (x+m, y+m+160);
  vertex (x+m, y+m+150);
  endShape();

  fill (155, 205, 231, go); // publica areas
  beginShape();
  vertex (x+m, y+m+160);
  vertex (x+m+88+150, y+m+160);
  vertex (x+m+88+150, y+m-30);
  vertex (x+m+88+160, y+m-30);
  vertex (x+m+88+160, y+m+170);
  vertex (x+m, y+m+170);
  vertex (x+m, y+m+160);
  endShape();

  fill (155, 205, 231, go); // uses of space
  beginShape();
  vertex (x+m, y+m+170);
  vertex (x+m+88+160, y+m+170);
  vertex (x+m+88+160, y+m-30);
  vertex (x+m+88+170, y+m-30);
  vertex (x+m+88+170, y+m+180);
  vertex (x+m, y+m+180);
  vertex (x+m, y+m+170);
  endShape();

  fill (155, 205, 231, fa); // building
  beginShape();
  vertex (x+m, y+m+180);
  vertex (x+m+88+170, y+m+180);
  vertex (x+m+88+170, y+m-30);
  vertex (x+m+88+180, y+m-30);
  vertex (x+m+88+180, y+m+190);
  vertex (x+m, y+m+190);
  vertex (x+m, y+m+180);
  endShape();

  fill (155, 205, 231, po); // landscape
  beginShape();
  vertex (x+m, y+m+190);
  vertex (x+m+88+180, y+m+190);
  vertex (x+m+88+180, y+m-30);
  vertex (x+m+88+190, y+m-30);
  vertex (x+m+88+190, y+m+200);
  vertex (x+m, y+m+200);
  vertex (x+m, y+m+190);
  endShape();

  fill (155, 205, 231, go); // points
  beginShape();
  vertex (x+m, y+m+200);
  vertex (x+m+88+190, y+m+200);
  vertex (x+m+88+190, y+m-30);
  vertex (x+m+88+200, y+m-30);
  vertex (x+m+88+200, y+m+210);
  vertex (x+m, y+m+210);
  vertex (x+m, y+m+200);
  endShape();
}

void escala() {

  int x=0;
  int y=335;
  myFont = createFont("arial", 10);
  textFont(myFont);

  fill(0);
  
  text ("C01", x+m, y+m);
  text ("C02", x+m, y+m+10);
  text ("C03", x+m, y+m+20);
  text ("C04", x+m, y+m+30);
  text ("C05", x+m, y+m+40);
  text ("C06", x+m, y+m+50);
  text ("C07", x+m, y+m+60);
  text ("C08", x+m, y+m+70);
  text ("C09", x+m, y+m+80);
  
  text ("C10", x+m+25, y+m+120);
  text ("C11", x+m+25, y+m+130);
  text ("C12", x+m+25, y+m+140);
  text ("C13", x+m+25, y+m+150);
  text ("C14", x+m+25, y+m+160);
  text ("C15", x+m+25, y+m+170);
  text ("C16", x+m+25, y+m+180);
  text ("C17", x+m+25, y+m+190);
  text ("C18", x+m+25, y+m+200);
}

// VEGETACAO

void vege () {

  PImage vedi, vedi2, vedi3, vedi4, vedi5, vedi6, vedi7, vedi8, vedi9, 
  vedi10, vedi11, vedi12, vedi13, vedi14, vedi15, vedi16, vedi17, vedi18;

    
    
    if (cont < quake) {
    image (palm, m-52, 235+m);
    image (veg5, m+10, 233+m);
    image (veg2, 95+m, 262+m);
    image (veg1, 110+m, 264+m);
    image (veg3, 125+m, 251+m);
    image (palm2, 161+m, 150+m);
    image (veg, 173+m, 246+m);
    image (veg6, 193+m, 240+m);
    image (veg4, 210+m, 220+m);
    image (veg8, 360+m, 254+m);
    image (veg7, 350+m, 190+m);
    image (veg9, 434+m, 244+m);
    image (veg10, 467+m, 244+m);
    image (veg11, 518+m, 206+m);
    image (veg12, 478+m, 216+m);
    image (veg13, 573+m, 190+m);
    image (veg14, 600+m, 230+m);
    image (veg15, 670+m, 238+m);
  } 
  if (cont > quake) {
    byte[] data=loadBytes("palmeira mak copy.jpg");
    byte[] data2=loadBytes("palmeira copy.jpg");
    byte[] data3=loadBytes("palmeira3 copy.jpg");
    byte[] data4=loadBytes("veg copy.jpg");
    byte[] data5=loadBytes("veg2 copy.jpg");
    byte[] data6=loadBytes("veg3 copy.jpg");
    byte[] data7=loadBytes("veg4 copy.jpg");
    byte[] data8=loadBytes("veg5 copy.jpg");
    byte[] data9=loadBytes("veg6 copy.jpg");
    byte[] data10=loadBytes("veg7 copy.jpg");
    byte[] data11=loadBytes("veg8 copy.jpg");
    byte[] data12=loadBytes("veg9 copy.jpg");
    byte[] data13=loadBytes("veg10 copy.jpg");
    byte[] data14=loadBytes("veg11 copy.jpg");
    byte[] data15=loadBytes("veg12 copy.jpg");
    byte[] data16=loadBytes("veg13 copy.jpg");
    byte[] data17=loadBytes("veg14 copy.jpg");
    byte[] data18=loadBytes("veg15 copy.jpg");

    for (int i=0; i<4; i++) // 1 changes
    {
      int loc=(int)random(1, data.length);//guess at header being 128 bytes at most..
      data[loc]=(byte)random(255);
      
      int loc2=(int)random(1, data2.length);//guess at header being 128 bytes at most..
      data2[loc2]=(byte)random(255);
      
      int loc3=(int)random(1, data3.length);//guess at header being 128 bytes at most..
      data3[loc3]=(byte)random(255);
      
      int loc4=(int)random(1, data4.length);//guess at header being 128 bytes at most..
      data4[loc4]=(byte)random(255);
      
      int loc5=(int)random(1, data5.length);//guess at header being 128 bytes at most..
      data5[loc5]=(byte)random(255);
      
      int loc6=(int)random(1, data6.length);//guess at header being 128 bytes at most..
      data6[loc6]=(byte)random(255);
      
      int loc7=(int)random(1, data7.length);//guess at header being 128 bytes at most..
      data7[loc7]=(byte)random(255);
      
      int loc8=(int)random(1, data8.length);//guess at header being 128 bytes at most..
      data8[loc8]=(byte)random(255);
      
      int loc9=(int)random(1, data9.length);//guess at header being 128 bytes at most..
      data9[loc9]=(byte)random(255);
      
      int loc10=(int)random(1, data10.length);//guess at header being 128 bytes at most..
      data10[loc10]=(byte)random(255);
      
      int loc11=(int)random(1, data11.length);//guess at header being 128 bytes at most..
      data11[loc11]=(byte)random(255);
      
      int loc12=(int)random(1, data12.length);//guess at header being 128 bytes at most..
      data12[loc12]=(byte)random(255);
      
      int loc13=(int)random(1, data13.length);//guess at header being 128 bytes at most..
      data13[loc13]=(byte)random(255);
      
      int loc14=(int)random(1, data14.length);//guess at header being 128 bytes at most..
      data14[loc14]=(byte)random(255);
      
      int loc15=(int)random(1, data15.length);//guess at header being 128 bytes at most..
      data15[loc15]=(byte)random(255);
      
      int loc16=(int)random(1, data16.length);//guess at header being 128 bytes at most..
      data16[loc16]=(byte)random(255);
      
      int loc17=(int)random(1, data17.length);//guess at header being 128 bytes at most..
      data17[loc17]=(byte)random(255);
      
      int loc18=(int)random(1, data18.length);//guess at header being 128 bytes at most..
      data18[loc18]=(byte)random(255);
    }
    saveBytes("vegedi1.jpg", data);
    vedi = loadImage("vegedi1.jpg");
    vedi.filter(THRESHOLD);
    
    saveBytes("vegedi2.jpg", data2);
    vedi2 = loadImage("vegedi2.jpg");
    vedi2.filter(THRESHOLD);
    
    saveBytes("vegedi3.jpg", data3);
    vedi3 = loadImage("vegedi3.jpg");
    vedi3.filter(THRESHOLD);
    
    saveBytes("vegedi4.jpg", data4);
    vedi4 = loadImage("vegedi4.jpg");
    vedi4.filter(THRESHOLD);
    
    saveBytes("vegedi5.jpg", data5);
    vedi5 = loadImage("vegedi5.jpg");
    vedi5.filter(THRESHOLD);
    
    saveBytes("vegedi6.jpg", data6);
    vedi6 = loadImage("vegedi6.jpg");
    vedi6.filter(THRESHOLD);
    
    saveBytes("vegedi7.jpg", data7);
    vedi7 = loadImage("vegedi7.jpg");
    vedi7.filter(THRESHOLD);
    
    saveBytes("vegedi8.jpg", data8);
    vedi8 = loadImage("vegedi8.jpg");
    vedi8.filter(THRESHOLD);
    
    saveBytes("vegedi9.jpg", data9);
    vedi9 = loadImage("vegedi9.jpg");
    vedi9.filter(THRESHOLD);
    
    saveBytes("vegedi10.jpg", data10);
    vedi10 = loadImage("vegedi10.jpg");
    vedi10.filter(THRESHOLD);
    
    saveBytes("vegedi11.jpg", data11);
    vedi11 = loadImage("vegedi11.jpg");
    vedi11.filter(THRESHOLD);
    
    saveBytes("vegedi12.jpg", data12);
    vedi12 = loadImage("vegedi12.jpg");
    vedi12.filter(THRESHOLD);
    
    saveBytes("vegedi13.jpg", data13);
    vedi13 = loadImage("vegedi13.jpg");
    vedi13.filter(THRESHOLD);
    
    saveBytes("vegedi14.jpg", data14);
    vedi14 = loadImage("vegedi14.jpg");
    vedi14.filter(THRESHOLD);
    
    saveBytes("vegedi15.jpg", data15);
    vedi15 = loadImage("vegedi15.jpg");
    vedi15.filter(THRESHOLD);
    
    saveBytes("vegedi16.jpg", data16);
    vedi16 = loadImage("vegedi16.jpg");
    vedi16.filter(THRESHOLD);
    
    saveBytes("vegedi17.jpg", data17);
    vedi17 = loadImage("vegedi17.jpg");
    vedi17.filter(THRESHOLD);
    
    saveBytes("vegedi18.jpg", data18);
    vedi18 = loadImage("vegedi18.jpg");
    vedi18.filter(THRESHOLD);
    
    image (vedi, m-52, 235+m);
    image (vedi2, 161+m, 150+m);
    image (vedi3, 173+m, 246+m);
    image (vedi4, 110+m, 264+m);
    image (vedi5, 95+m, 262+m);
    image (vedi6, 125+m, 251+m);
    image (vedi7, 210+m, 220+m);
    image (vedi8, m+10, 233+m);
    image (vedi9, 193+m, 240+m);
    image (vedi10, 350+m, 190+m);
    image (vedi11, 360+m, 254+m);
    image (vedi12, 434+m, 244+m);
    image (vedi13, 467+m, 244+m);
    image (vedi14, 518+m, 206+m);
    image (vedi15, 478+m, 216+m);
    image (vedi16, 573+m, 190+m);
    image (vedi17, 600+m, 230+m);
    image (vedi18, 670+m, 238+m);

  }
  if (cont > quake+7){
    cont=0;
  }
}

// WAIT

class Wait {

  float x, y, d, r;
  int i;

  public Wait (float xin, float yin, float din, float rin) {

    x=xin;
    y=yin;
    d=din;
    r=rin;
  }

  void plot () {

    i++;

    if (i < r) {
      noStroke();
      fill (155, 205, 231);
      beginShape();
      vertex (x+m, y+m);
      vertex (m+x+d*1.6, y+m);
      vertex (m+x+d*1.6, m+y+d);
      vertex (m+x+d*0.8, m+y+d);
      vertex (m+x+d*0.8, m+y+d*1.3);
      vertex (m+x+d*0.4, m+y+d);
      vertex (x+m, m+y+d);
      vertex (x+m, y+m);
      endShape();
      
      myFont = createFont("arial",14);
      textFont(myFont);
      fill(255);
      text ("WAIT", m+x+d*0.2, m+y+d*0.65);
    }
    if (i > 1.5*r) {
      i = 0;
    }
  }
}
