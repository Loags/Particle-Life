UI ui;
Life life;
GravitationMatrix gravitationMatrix;

ArrayList<Particle> particles;
float gravitationalConstant = 1;
int simulationSpeed;

void setup() {
  frameRate(120);
  size(750, 750);
  background(0);

  ui = new UI(this);

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 1000; i++) {
    float spawnPosX = random(width);
    float spawnPosY = random(height);
    ParticleType pType = ParticleType.values()[int(random(0, (float)ParticleType.values().length))];
    particles.add(new Particle(new PVector(spawnPosX, spawnPosY), pType));
  }

  gravitationMatrix = new GravitationMatrix();
  life = new Life(particles);
}

void draw() {
  background(0);

  for (int i = 0; i < simulationSpeed; i++)
  {
    life.Update();
  }
  life.Render();
  ui.Render();
}

void mousePressed() {
  gravitationMatrix.InputGravitationMatrix();
}
