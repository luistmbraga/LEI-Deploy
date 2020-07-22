
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include <GL/glut.h>


float camX = 00, camY = 30, camZ = 40;
int startX, startY, tracking = 0;

float alpha = 0, beta = 35, r = 10;

int w,h;
char s[30];
float time=0,timebase=0;
int frame=0;

float orange[4] = {0.8f, 0.4f , 0.4f,1.0f};
float green[4] = {0.4f, 0.8f, 0.4f, 1.0f};
float black[4] = {0.0f,0.0f,0.0f,0.0f};
float white[4] = {1.0f, 1.0f , 1.0f,1.0f};


void changeSize(int w, int h) {

	float ratio;

	// Prevent a divide by zero, when window is too short
	// (you cant make a window of zero width).
	if(h == 0)
		h = 1;

	ratio = 1.0f * w / h;

	// Reset the coordinate system before modifying
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set the clipping volume
	gluPerspective(45,ratio,1,1000);
	glMatrixMode(GL_MODELVIEW);
}


void drawSnowMan() {

	glMaterialfv(GL_FRONT,GL_AMBIENT_AND_DIFFUSE, white);

// Draw Body	
	glTranslatef(0.0f ,0.75f, 0.0f);
	glutSolidSphere(0.75f,20,20);

// Draw Head
	glTranslatef(0.0f, 1.0f, 0.0f);
	glutSolidSphere(0.25f,20,20);

// Draw Eyes
	glPushMatrix();
	glMaterialfv(GL_FRONT,GL_AMBIENT_AND_DIFFUSE, black);
	glTranslatef(0.05f, 0.10f, 0.18f);
	glutSolidSphere(0.05f,10,10);
	glTranslatef(-0.1f, 0.0f, 0.0f);
	glutSolidSphere(0.05f,10,10);
	glPopMatrix();

// Draw Nose
	glMaterialfv(GL_FRONT,GL_AMBIENT_AND_DIFFUSE, orange);
	glRotatef(0.0f,1.0f, 0.0f, 0.0f);
	glutSolidCone(0.08f,0.5f,10,2);
}


void drawSnowMan(int code) {

	float color = code / 256.0f;

	glColor3f(color, color, color);

// Draw Body	
	glTranslatef(0.0f ,0.75f, 0.0f);
	glutSolidSphere(0.75f,20,20);


// Draw Head
	glTranslatef(0.0f, 1.0f, 0.0f);
	glutSolidSphere(0.25f,20,20);

// Draw Eyes
	glPushMatrix();
	glTranslatef(0.05f, 0.10f, 0.18f);
	glutSolidSphere(0.05f,10,10);
	glTranslatef(-0.1f, 0.0f, 0.0f);
	glutSolidSphere(0.05f,10,10);
	glPopMatrix();

// Draw Nose
	glRotatef(0.0f,1.0f, 0.0f, 0.0f);
	glutSolidCone(0.08f,0.5f,10,2);
}


void init() {

	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);

	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);

	camX = r * sin(alpha * 3.14 / 180.0) * cos(beta * 3.14 / 180.0);
	camZ = r * cos(alpha * 3.14 / 180.0) * cos(beta * 3.14 / 180.0);
	camY = r * 							   sin(beta * 3.14 / 180.0);

}


void renderScene(void) {

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	gluLookAt(camX, camY, camZ, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

// Draw ground

	glMaterialfv(GL_FRONT,GL_AMBIENT_AND_DIFFUSE, green);
		
	glBegin(GL_QUADS);
	glNormal3f(0.0, 1.0f, 0.0f);
		glVertex3f(-100.0f, 0.0f, -100.0f);
		glVertex3f(-100.0f, 0.0f,  100.0f);
		glVertex3f( 100.0f, 0.0f,  100.0f);
		glVertex3f( 100.0f, 0.0f, -100.0f);
	glEnd();

// Draw SnowMen
	for(int i = 0; i < 2; i++)
		for(int j=0; j < 2; j++) {
			glPushMatrix();
			glTranslatef(i*5.0-2.5f,0,j * 5.0-2.5f);
			drawSnowMan();
			glPopMatrix();
		}

	frame++;
	time=glutGet(GLUT_ELAPSED_TIME);
	if (time - timebase > 1000) {
		sprintf(s,"FPS:%4.2f",frame*1000.0/(time-timebase));
		timebase = time;		
		frame = 0;
		glutSetWindowTitle(s);
	}
	glutSwapBuffers();
}


// Exerc�cio: escrever a fun��o picking
// par�metros: coordenadas do rato na janela

unsigned char  picking(int x, int y) {

}


// ----------------------------------------------------------
//				MOUSE AND KEYBOARD
// ----------------------------------------------------------


void processNormalKeys(unsigned char key, int x, int y) {

	switch(key) {
	
		case 27: exit(0);
		case 'c': printf("Camera : %f %f %f\n", alpha, beta, r); break;
	}
}


void processMouseButtons(int button, int state, int xx, int yy) 
{
	if (state == GLUT_DOWN)  {
		startX = xx;
		startY = yy;
		if (button == GLUT_LEFT_BUTTON)
			tracking = 1;
		else if (button == GLUT_RIGHT_BUTTON)
			tracking = 2;
		else { // Middle button
			tracking = 0;
			unsigned char result = picking(xx,yy);
			if (result)
				printf("Picked Snowman number %d\n", result);
			else
				printf("Nothing selected\n");
		}
	}
	else if (state == GLUT_UP) {
		if (tracking == 1) {
			alpha += (xx - startX);
			beta += (yy - startY);
		}
		else if (tracking == 2) {
			
			r -= yy - startY;
			if (r < 3)
				r = 3.0;
		}
		tracking = 0;
	}
}


void processMouseMotion(int xx, int yy)
{

	int deltaX, deltaY;
	int alphaAux, betaAux;
	int rAux;

	if (!tracking)
		return;

	deltaX = xx - startX;
	deltaY = yy - startY;

	if (tracking == 1) {


		alphaAux = alpha + deltaX;
		betaAux = beta + deltaY;

		if (betaAux > 85.0)
			betaAux = 85.0;
		else if (betaAux < -85.0)
			betaAux = -85.0;

		rAux = r;
	}
	else if (tracking == 2) {

		alphaAux = alpha;
		betaAux = beta;
		rAux = r - deltaY;
		if (rAux < 3)
			rAux = 3;
	}
	camX = rAux * sin(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
	camZ = rAux * cos(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
	camY = rAux * 							     sin(betaAux * 3.14 / 180.0);

	glutPostRedisplay();
}



int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(640,360);
	glutCreateWindow("Picking SnowMen from CG @ DI");

// registo de fun��es 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);

// registo da fun��es do teclado e rato
	glutKeyboardFunc(processNormalKeys);
	glutMouseFunc(processMouseButtons);
	glutMotionFunc(processMouseMotion);

	init();

	glutMainLoop();

	return(0);
}
