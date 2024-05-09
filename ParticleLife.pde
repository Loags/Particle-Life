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

void SpawnGradientParticles() {
  int particleCount = 1000;  // Total number of particles
  int numTypes = ParticleType.values().length;
  float widthPerType = width / (float) numTypes;  // Horizontal space allocated per type

  // Clear existing particles
  particles.clear();

  for (int i = 0; i < particleCount; i++) {
    float posX = width * (i / (float) particleCount);  // Calculate x position linearly across the width
    float posY = random(height * 0.2f, height * 0.8f);  // Randomize y position within middle 60% of the screen

    // Calculate the type index based on the x position
    int typeIndex = (int) (posX / widthPerType);
    typeIndex = min(typeIndex, numTypes - 1);  // Ensure the index does not exceed the number of types

    ParticleType pType = ParticleType.values()[typeIndex];
    Particle newParticle = new Particle(new PVector(posX, posY), pType);
    particles.add(newParticle);
  }
}
