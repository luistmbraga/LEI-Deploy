#include <stdlib.h>
#include <GL/glut.h>

#include <math.h>

#define _PI_ 3.14159

float alpha = 0.0f, beta = 0.0f, radius = 5.0f;
float camX, camY, camZ;

// declare variables for VBO id 
//...

void sphericalToCartesian() {

	camX = radius * cos(beta) * sin(alpha);
	camY = radius * sin(beta);
	camZ = radius * cos(beta) * cos(alpha);
}


void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

	// compute window's aspect ratio 
	float ratio = w * 1.0 / h;

	// Reset the coordinate system before modifying
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set the correct perspective
	gluPerspective(45,ratio,1,1000);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}


/*----------------------------------------------------------------------------------- 
	Drawing cylinder with VBOs 
-----------------------------------------------------------------------------------*/

void drawCylinder() {

//	Bind and semantics

//  Draw
}

/*----------------------------------------------------------------------------------- 
	Create the VBO for the cylinder
-----------------------------------------------------------------------------------*/

void prepareCylinder(float altura,float radius,int lados) {

//	Enable buffer

// Allocate and fill vertex array

// Generate VBOs
}

/*----------------------------------------------------------------------------------- 
		RENDER SCENE
-----------------------------------------------------------------------------------*/

void renderScene(void) {

	float pos[4] = {1.0, 1.0, 1.0, 0.0};

	glClearColor(0.0f,0.0f,0.0f,0.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();
	glLightfv(GL_LIGHT0, GL_POSITION, pos);
	gluLookAt(camX,camY,camZ, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

	drawCylinder();

// End of frame
	glutSwapBuffers();
}


// special keys processing function
void processKeys(int key, int xx, int yy) 
{
	switch(key) {
	
		case GLUT_KEY_RIGHT: 
						alpha -=0.1; break;

		case GLUT_KEY_LEFT: 
						alpha += 0.1; break;

		case GLUT_KEY_UP : 
						beta += 0.1f;
						if (beta > 1.5f)
							beta = 1.5f;
						break;

		case GLUT_KEY_DOWN: 
						beta -= 0.1f; 
						if (beta < -1.5f)
							beta = -1.5f;
						break;

		case GLUT_KEY_PAGE_UP : radius -= 0.1f; 
			if (radius < 0.1f)
				radius = 0.1f;
			break;

		case GLUT_KEY_PAGE_DOWN: radius += 0.1f; break;
	
	}
	sphericalToCartesian();
	glutPostRedisplay();
}


void main(int argc, char **argv) {

// initialization
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(320,320);
	glutCreateWindow("CG@DI-UM");
		
// callback registry 
	glutDisplayFunc(renderScene);
	glutIdleFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutSpecialFunc(processKeys);

// OpenGL settings 
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);

// init
	sphericalToCartesian();
	prepareCylinder(2,1,10);

// enter GLUTs main cycle
	glutMainLoop();
}

