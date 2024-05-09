import controlP5.*;

ArrayList<Particle> particles;
Life life;
float gravitationalConstant = 1;
int simulationSpeed;
import controlP5.*;
ControlP5 cp5;


void setup() {
  frameRate(120);
  size(750, 750);
  background(0);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 1000; i++) {
    float spawnPosX = random(width);
    float spawnPosY = random(height);
    ParticleType pType = ParticleType.values()[(int)random(3)];
    particles.add(new Particle(new PVector(spawnPosX, spawnPosY), pType));
  }
  life = new Life(particles);

  cp5 = new ControlP5(this);
  cp5.addSlider("simulationSpeed").setPosition(20, 20).setWidth(200).setRange(0, 5).setValue(1);
  cp5.addSlider("gravitationalConstant").setPosition(20, 40).setWidth(200).setRange(0, 10).setValue(1);
}

void draw() {
  background(0);
  for (int i = 0; i < simulationSpeed; i++)
  {
    life.Update();
  }
  life.Render();

  // Display frame rate
  fill(255);
  textSize(16);
  textAlign(RIGHT, TOP);
  text("FPS: " + nf(frameRate, 0, 2), width - 10, 10);
}
