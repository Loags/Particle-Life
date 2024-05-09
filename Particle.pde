public enum ParticleType {
  red,
    green,
    blue,
    //lightblue,
    //pink,
    //yellow
};

int GetColorForType(int typeIndex) {
  switch (typeIndex) {
  case 0:
    return color(255, 0, 0); // Red
  case 1:
    return color(0, 255, 0); // Green
  case 2:
    return color(0, 0, 255); // Blue
  case 3:
    return color(0, 255, 255); // Light Blue
  case 4:
    return color(255, 0, 255); // Pink
  case 5:
    return color(255, 255, 0); // Yellow
  default:
    return color(100); // Gray for undefined types
  }
}

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
    color c = GetColorForType(type.ordinal());

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
