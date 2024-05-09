import controlP5.*;

class UI {
  ControlP5 cp5;
  GravitationMatrix gravitationMatrix;

  UI(ParticleLife _particleLife) {
    cp5 = new ControlP5(_particleLife);
    cp5.addSlider("simulationSpeed").setPosition(20, 20).setWidth(200).setRange(0, 5).setValue(1);
    cp5.addSlider("gravitationalConstant").setPosition(20, 40).setWidth(200).setRange(0, 10).setValue(1);

    gravitationMatrix = new GravitationMatrix();
  }

  void Render() {
    // GravitationMatrix
    gravitationMatrix.Render();

    // Display frame rate
    fill(255);
    textSize(16);
    textAlign(RIGHT, TOP);
    text("FPS: " + nf(frameRate, 0, 2), width - 10, 10);
  }
}
