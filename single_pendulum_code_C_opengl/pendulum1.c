#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <GL/glut.h>
#include "math.h"

using namespace std;

const int ms_per_frame = 5;  // min ms per frame 

int time_step_counter = -1;
double *thetas, *vs;
int l = 10, N = 7500;
double g = 9.8, theta0 = 3.1416/4, v0 = 0, ti = 0, tf = 20;


void timer(int id) {
    time_step_counter++;
    if(time_step_counter >= N){
        time_step_counter = 0;
    }
    glutPostRedisplay();
}
 

/* du/dt = f with f = [ u(2); -(g/l)*sin(u(1)) ] */
void rk4_sys_integrator(double g, int l, double theta0, double v0, int N, double ti, double tf, double **thetas, double **vs){
    double h = (ti - tf)/N; 
    double t = ti;
    double theta, v, k11, k12, k21, k22, k31, k32, k41, k42;
    int i;

    *thetas = (double*)malloc(N*sizeof(double));
    *vs = (double*)malloc(N*sizeof(double));

    theta = theta0;
    v = v0;
    for(i = 0; i<N; i++){
        k11 = h*v; 
        k12 = -h*(g/l)*sin(theta);

        k21 = h*(v + k11/2);
        k22 = -h*(g/l)*sin(theta + k12/2);

        k31 = h*(v + k21/2);
        k32 = -h*(g/l)*sin(theta + k22/2);

        k41 = h*(v + k31);
        k42 =  -h*(g/l)*sin(theta + k32);

        theta = theta + (k11 + 2*k21 + 2*k31 + k41)/6;
        v = v + (k12 + 2*k22 + 2*k32 + k42)/6;

        printf("i = %d, assigning theta = %f and v = %f\n", i, theta, v);
        (*thetas)[i] = theta;
        (*vs)[i] = v;
   }
}



void drawPendulum(double theta) {
    glEnable(GL_LINE_SMOOTH);

    // The pendulum support anchor block
    glColor3f(0.7, 0.7, 0.7);
    glBegin(GL_QUADS);
    glNormal3f( 0.0,  0.0,  1.0);
    glVertex3d(-0.8,  0.0,  0.0);
    glVertex3d( 0.8,  0.0,  0.0);
    glVertex3d( 0.8,  0.8,  0.0);
    glVertex3d(-0.8,  0.8,  0.0);
    glEnd();



    // The pendulum bob
    double pi = 3.1416;
    double x1 = 0, y1 = 0;
    double x2, y2;
    if(0 <= theta < pi/2){
            x2 = l*cos(pi/2-theta);
            y2 = -l*sin(pi/2-theta);
    }
    else if(pi/2 <= theta < pi){
            x2 = l*cos(theta - pi/2);
            y2 = l*sin(theta - pi/2);
    }
    else if(-pi/2 <= theta < 0){
            x2 = -l*cos(pi/2-abs(theta));
            y2 = -l*sin(pi/2-abs(theta));
    }
    else if(-pi <= theta < -pi/2){
            x2 = -l*cos(abs(theta) - pi/2);
            y2 = l*sin(abs(theta) - pi/2);
    }
    else{
        printf("invalid theta\n");
    }
 
    glColor3f(0.2, 0.65, 0.4);
    glPushMatrix();
    glTranslated(x2, y2, 0.0);
    glutWireSphere(0.82, 50, 50);
    glPopMatrix();

    // thick line connecting the two
    glLineWidth(200);
    glColor3f(0.8, 0.25, 0.4);
    glBegin(GL_LINES);
    glVertex2f(x1,y1);
    glVertex2f(x2,y2);
    glEnd();
}

void display(void) {
    glutTimerFunc(ms_per_frame,timer,1);  

    glClearColor (0.0,0.0,0.0,1.0);
    glClear (GL_COLOR_BUFFER_BIT);
    glLoadIdentity();
    glTranslatef(0,0,-20);
    glColor3f(1,1,1);

    printf("time_step_counter = %d, drawing pendulum with angle %f\n", time_step_counter, thetas[time_step_counter]);
    drawPendulum(thetas[time_step_counter]);
    glutSwapBuffers();
}

void reshape (int w, int h) {
    glViewport (0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    gluPerspective (60, (GLfloat)w / (GLfloat)h, 0.1, 100.0);
    glMatrixMode (GL_MODELVIEW);
}

/* quit on escape key press */
void keyboard(unsigned char key, int x, int y){
    switch (key) {
        case 27:
            exit(0);
            break;
    }
}

 
int main (int argc, char **argv) {
    glutInit (&argc, argv);
    glutInitDisplayMode (GLUT_DOUBLE);
    glutInitWindowSize (1200, 800);
    glutInitWindowPosition (0, 0);
    glutCreateWindow ("Single Pendulum Simulation");

    printf("running RK4..\n");
    rk4_sys_integrator(g, l, theta0, v0, N, ti, tf, &thetas, &vs);

    glutDisplayFunc (display);
    //glutIdleFunc (display);
    glutReshapeFunc (reshape);
    glutKeyboardFunc (keyboard);
    glutMainLoop ();

    return 0;
} 

