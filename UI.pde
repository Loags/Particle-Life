import controlP5.*;

class UI {
  ControlP5 cp5;

  UI(ParticleLife _particleLife) {
    cp5 = new ControlP5(_particleLife);
    
    cp5.addSlider("simulationSpeed").setPosition(20, 20).setWidth(200).setRange(0, 5).setValue(1);
    cp5.addSlider("gravitationalConstant").setPosition(20, 40).setWidth(200).setRange(0, 5).setValue(1);
    cp5.addButton("Toggle Matrix").setPosition(60, 65).setSize(100, 20).onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        gravitationMatrix.isVisible = !gravitationMatrix.isVisible;
      }
    }
    );
    cp5.addButton("Shuffle Matrix").setPosition(60, 90).setSize(100, 20).onPress(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        gravitationMatrix.ShuffleMatrix();
      }
    }
    );
    cp5.addButton("Reset Matrix").setPosition(60, 115).setSize(100, 20).onPress(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        gravitationMatrix.ResetMatrix();
      }
    }
    );
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
