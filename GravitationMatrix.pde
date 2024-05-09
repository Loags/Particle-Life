class GravitationMatrix {
  float[][] gravMatrix;
  int cellSize = 40;
  int numTypes;
  boolean isVisible = true;
  int matrixStartX = 50;
  int matrixStartY = 175;

  GravitationMatrix() {
    this.numTypes = ParticleType.values().length;
    gravMatrix = new float[numTypes][numTypes];

    InitializeDefaultMatrix();
  }

  void InitializeDefaultMatrix() {
    for (int i = 0; i < numTypes; i++) {
      for (int j = 0; j < numTypes; j++) {
        if (i == j)
          gravMatrix[i][j] = 1.0; // default attraction value same types
        else
          gravMatrix[i][j] = -1; // default attraction value different types
      }
    }
  }

  void ModifyGravMatrix() {
    int counter = 0;
    for (int i = 0; i < numTypes; i++) {
      for (int j = 0; j < numTypes; j++) {
        if (i == j) {
          gravMatrix[i][j] = 1.0;  // Strong attraction to same type
        } else if (abs(i - j) == 1) {
          if (counter % 2 == 0) // Only the upper fields
            gravMatrix[i][j] = 0.5;  // Weaker attraction to adjacent types
          counter+=1;
        } else {
          gravMatrix[i][j] = 0;    // No attraction to distant types
        }
      }
    }
    // Set the bottom-left entry of the matrix to -0.5 explicitly
    gravMatrix[numTypes - 1][0] = -0.5; // Assuming numTypes indexes are 0-based
  }

  void Render() {
    if (!isVisible) return;

    textAlign(CENTER, CENTER);
    textSize(12);
    for (int i = 0; i < numTypes; i++) {
      fill(GetColorForType(i));
      ellipse(matrixStartX - 40 + cellSize / 2, matrixStartY + i * cellSize + cellSize / 2, cellSize / 2, cellSize / 2);
      ellipse(matrixStartX + i * cellSize + cellSize / 2, matrixStartY - 40 + cellSize / 2, cellSize / 2, cellSize / 2);

      for (int j = 0; j < numTypes; j++) {
        float val = gravMatrix[i][j];
        int colorValue = (int) map(val, -1, 1, 0, 255);
        fill(color(255 - colorValue, colorValue, 0));
        rect(matrixStartX + j * cellSize, matrixStartY + i * cellSize, cellSize, cellSize);

        // Display the value of gravMatrix[i][j] inside the corresponding cell
        fill(255);
        text(nf(val, 0, 2), matrixStartX + j * cellSize + cellSize / 2, matrixStartY + i * cellSize + cellSize / 2);
      }
    }
  }

  void InputGravitationMatrix() {
    // Check if the mouse is within the bounds of the matrix
    if (mouseX >= matrixStartX && mouseX <= matrixStartX + numTypes * cellSize &&
      mouseY >= matrixStartY && mouseY <= matrixStartY + numTypes * cellSize) {
      // Calculate which cell is clicked based on mouse position
      int i = (mouseY - matrixStartY) / cellSize;
      int j = (mouseX - matrixStartX) / cellSize;

      // Check if the calculated indices are within the bounds of the matrix
      if (i >= 0 && i < numTypes && j >= 0 && j < numTypes) {
        if (mouseButton == LEFT) {
          gravMatrix[i][j] -= 0.2;
        } else if (mouseButton == RIGHT) {
          gravMatrix[i][j] += 0.2;
        }

        // Ensure the matrix values are constrained between -1 and 1
        gravMatrix[i][j] = constrain(gravMatrix[i][j], -1, 1);
      }
    }
  }

  void ShuffleMatrix() {
    for (int i = 0; i < numTypes; i++) {
      for (int j = 0; j < numTypes; j++) {
        gravMatrix[i][j] = random(-1.0, 1.0);
      }
    }
  }

  void ResetMatrix() {
    for (int i = 0; i < numTypes; i++) {
      for (int j = 0; j < numTypes; j++) {
        if (i == j)
          gravMatrix[i][j] = 1.0; // default attraction value same types
        else
          gravMatrix[i][j] = 0.0; // default attraction value different types
      }
    }
  }
}
