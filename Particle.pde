public enum ParticleType {
  red,
    green,
    blue,
    lightblue,
    pink,
    yellow
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
    LimitVelocity();
    position.add(velocity);
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
    //velocity.mult(0.99); // Damping the speed
  }

  /* toroidal wrapping
   void Attract(Particle other, float[][] gravMatrix) {
   float dx = other.position.x - this.position.x;
   float dy = other.position.y - this.position.y;
   
   // Calculate the minimum distance considering toroidal wrapping
   float wrappedDx = dx;
   float wrappedDy = dy;
   
   if (abs(dx) > width / 2) {
   wrappedDx = width - abs(dx) * (dx > 0 ? -1 : 1);
   }
   if (abs(dy) > height / 2) {
   wrappedDy = height - abs(dy) * (dy > 0 ? -1 : 1);
   }
   
   // Calculate the distance using wrapped values
   float distance = sqrt(wrappedDx * wrappedDx + wrappedDy * wrappedDy);
   PVector force = new PVector(wrappedDx, wrappedDy);
   if (distance > 0 && distance < 100) { // Make sure to apply forces only at a logical range
   force.normalize();
   float strength = 0;
   
   if (distance < 10) {  // Apply repulsive force for very close distances
   strength = -100 / (distance * distance);  // Strong repulsion
   } else {
   // Normal attraction or neutral interaction
   strength = (gravMatrix[this.type.ordinal()][other.type.ordinal()] * gravitationalConstant * this.mass * other.mass) / (distance * distance);
   }
   
   force.mult(strength);
   this.ApplyForce(force);
   }
   }*/


  void Attract(Particle other, float[][] gravMatrix) {
    float dx = other.position.x - position.x;
    float dy = other.position.y - position.y;

    // Apply periodic boundary conditions
    dx = dx - width * round(dx / width);
    dy = dy - height * round(dy / height);

    // Calculate the squared distance using the shortest wrapped path
    float distanceSquared = dx * dx + dy * dy;
    float distance = sqrt(distanceSquared);

    if (distanceSquared < (radius * radius)) {  // Prevent extreme forces at very small distances
      return;
    }

    PVector force = new PVector(dx, dy);
    force.normalize();

    // Calculate the strength of the force based on the type of particles and distance
    float strength;
    if (distance < 10) {  // Apply a repulsive force for very close distances
      strength = -100 / distanceSquared;  // Strong repulsion at close range
    } else {
      strength = (gravMatrix[this.type.ordinal()][other.type.ordinal()] * gravitationalConstant * mass * other.mass) / distanceSquared;
    }

    force.mult(strength);
    ApplyForce(force);
  }


  void CheckEdges() {
    if (position.x < 0) {
      position.x = width + position.x;
    } else if (position.x > width) {
      position.x = position.x - width;
    }

    if (position.y < 0) {
      position.y = height + position.y;
    } else if (position.y > height) {
      position.y = position.y - height;
    }
  }
}
