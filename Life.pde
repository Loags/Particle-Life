class Life {
  ArrayList<Particle> particles;

  Life(ArrayList<Particle> particles) {
    this.particles = particles;
  }

  void Update() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      for (int j = 0; j < particles.size(); j++) {
        if (i != j) {
          p.Attract(particles.get(j));
        }
      }
      p.Update();
    }
  }

  void Render() {
    for (Particle p : particles) {
      p.Render();
    }
  }
}
