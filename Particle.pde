public enum ParticleType {
  red, green, blue
};

class Particle {
  PVector position;
  PVector velocity;
  float mass;
  float radius;
  ParticleType type;
  float maxVelocity = 2.0;

  Particle(PVector _position, ParticleType _type) {
    position = _position;
    velocity = new PVector(0, 0);
    mass = 5;
    radius = 2.5;
    type = _type;
  }

  void Render() {
    color c = color(0, 0, 0);
    if (type == ParticleType.red)
      c = color(255, 0, 0);
    else if (type == ParticleType.green)
      c = color(0, 255, 0);
    else if (type == ParticleType.blue)
      c = color(0, 0, 255);

    fill(c);
    noStroke();
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }

  void Update() {
    position.add(velocity);
    LimitVelocity();
    CheckEdges();
  }

  void LimitVelocity() {
    if (velocity.magSq() > maxVelocity * maxVelocity) { // Check if the velocity magnitude squared is greater than max velocity squared
      velocity.normalize(); // Maintain direction but reset magnitude
      velocity.mult(maxVelocity);
    }
  }

  void ApplyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    velocity.add(f);
    velocity.mult(0.99); // Damping the speed
  }

  void Attract(Particle other) {
    PVector force = PVector.sub(other.position, this.position);
    float distance = force.mag();
    force.normalize();

    if (distance < 25) {
      float repulsiveStrength = -50 / (distance * distance);
      force.mult(repulsiveStrength);
      this.ApplyForce(force);
    } else if (this.type == other.type && distance < 100) {
      float attractiveStrength = (gravitationalConstant * this.mass * other.mass) / (distance * distance);
      force.mult(attractiveStrength);
      this.ApplyForce(force);
    }
  }

  void CheckEdges() {
    if (position.x < 0 - radius * 2) {
      position.x = width;
    } else if (position.x > width + radius * 2) {
      position.x = 0;
    }

    if (position.y < 0 - radius * 2) {
      position.y = height;
    } else if (position.y > height + radius * 2) {
      position.y = 0;
    }
  }
}
