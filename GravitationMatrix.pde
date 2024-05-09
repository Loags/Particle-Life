float[][] gravMatrix;

class GravitationMatrix {
  int cellSize = 40;
  int numTypes;
  PVector[] typePositions; // For drawing labels

  GravitationMatrix() {
    this.numTypes = ParticleType.values().length;
    gravMatrix = new float[numTypes][numTypes];
    typePositions = new PVector[numTypes];
    for (int i = 0; i < numTypes; i++) {
      for (int j = 0; j < numTypes; j++) {
        gravMatrix[i][j] = 0.0; // default attraction value
      }
      typePositions[i] = new PVector(650 + i * cellSize + cellSize / 2, 50); // Position for labels above matrix
    }
  }

  void Render() {
    textAlign(CENTER, CENTER);
    textSize(12);
    for (int i = 0; i < numTypes; i++) {
      // Draw the type labels
      fill(GetColorForType(i));
      ellipse(typePositions[i].x, typePositions[i].y, cellSize / 2, cellSize / 2);
      ellipse(600, 100 + i * cellSize + cellSize / 2, cellSize / 2, cellSize / 2);

      for (int j = 0; j < numTypes; j++) {
        float val = gravMatrix[i][j];
        int colorValue = (int) map(val, -1, 1, 0, 255);
        fill(color(255 - colorValue, colorValue, 0));  // Interpolate between red and green
        rect(650 + j * cellSize, 100 + i * cellSize, cellSize, cellSize);
      }
    }
  }

  void InputGravitationMatrix() {
    if (mouseX >= 650 && mouseX <= 650 + numTypes * cellSize &&
      mouseY >= 100 && mouseY <= 100 + numTypes * cellSize) {
      int i = (mouseY - 100) / cellSize;
      int j = (mouseX - 650) / cellSize;
      if (i >= 0 && i < numTypes && j >= 0 && j < numTypes) {
        if (mouseButton == LEFT) {
          gravMatrix[i][j] -= 0.2;
        } else if (mouseButton == RIGHT) {
          gravMatrix[i][j] += 0.2;
        }
        gravMatrix[i][j] = constrain(gravMatrix[i][j], -1, 1);
      }
    }
  }
}
