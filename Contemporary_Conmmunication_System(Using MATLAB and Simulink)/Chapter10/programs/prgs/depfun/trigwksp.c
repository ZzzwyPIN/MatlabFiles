/* $Revision: 1.21 $ */
/*
 * TRIGWKSP   A Simulink triggered read from workspace
 *
 *           Syntax:  [sys, x0] = TRIGWKSP(t,x,u,flag,var, thd, cycl_flag, ini)
 *      This function is for the Simulink Triggered read-from-workspace block.
 *      The block outputs a row of VAR at the rising edge of of the input
 *      impulse. The output impulse equals the colomn number of VAR. The 
 *      rising edge of the trigger signal is detected when it is greater than 
 *      or equal to the threshold. When the output index is greater than
 *      the row number of VAR, the block outputs zero if cycl_flag == 0.
 *      The block returns to the very begining of the VAR and cyclically
 *      outputs the same variable again when cycl_flag ~= 0.
 *
 * Wes Wang  August 25, 1994
 * Copyright 1996-2001 The MathWorks, Inc.
 */

#define S_FUNCTION_NAME trigwksp

#ifdef MATLAB_MEX_FILE
#include "mex.h"      /* needed for declaration of mexErrMsgTxt */
#endif

/*
 * need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */

#include "simstruc.h"
#include "tmwtypes.h"

/* For RTW */
#if defined(RT) || defined(NRT)  
#undef  mexPrintf
#define mexPrintf printf
#endif

/*
 * Defines for easy access of the input parameters
 */

#define NUM_ARGS       4
#define VARIABLE       ssGetArg(S,0)
#define THRESHOLD      ssGetArg(S,1)
#define CYCL_FLAG      ssGetArg(S,2)
#define INIOUTPUT      ssGetArg(S,3)

/*
 * mdlInitializeSizes - called to initialize the sizes array stored in
 *                      the SimStruct.  The sizes array defines the
 *                      characteristics (number of inputs, outputs,
 *                      states, etc.) of the S-Function.
 */

static void mdlInitializeSizes(SimStruct *S)
{
    /*
     * Set-up size information.
     */ 
    
    if (ssGetNumArgs(S) == NUM_ARGS) {
	int_T numOutput, maxBuffer;

	numOutput = mxGetN(VARIABLE);
	maxBuffer = mxGetM(VARIABLE);
	if (numOutput < 1) {
#ifdef MATLAB_MEX_FILE
	    char_T err_msg[256];
	    sprintf(err_msg, "Input variable is empty.");
	    mexErrMsgTxt(err_msg);
#endif    
        }

	if ((mxGetM(THRESHOLD) != 1) || (mxGetN(THRESHOLD) != 1) ) {
#ifdef MATLAB_MEX_FILE
	    char_T err_msg[256];
	    sprintf(err_msg, "Threshold must be a scalar.");
	    mexErrMsgTxt(err_msg);
#endif    
        }

	if ((mxGetM(CYCL_FLAG) != 1) || (mxGetN(CYCL_FLAG) != 1) ) {
#ifdef MATLAB_MEX_FILE
	    char_T err_msg[256];
	    sprintf(err_msg, "Cyclic flag must be a scalar.");
	    mexErrMsgTxt(err_msg);
#endif    
        }               
        
        ssSetNumContStates(    S, 0);
	ssSetNumDiscStates(    S, 0);
	ssSetNumInputs(        S, 1);
	ssSetNumOutputs(       S, numOutput);
	ssSetDirectFeedThrough(S, 1);
	ssSetNumInputArgs(     S, NUM_ARGS);
	ssSetNumSampleTimes(   S, 1);
	ssSetNumRWork(         S, 0);
	ssSetNumIWork(         S, 2);  /*Index and lastTrig*/
	ssSetNumPWork(         S, 0);
    } else {
#ifdef MATLAB_MEX_FILE
	char_T err_msg[256];
	sprintf(err_msg, "Wrong number of input arguments passed to S-function MEX-file.\n"
		"%d input arguments were passed in when expecting %d input arguments.\n", ssGetNumArgs(S) + 4, NUM_ARGS + 4);
	mexErrMsgTxt(err_msg);
#endif
    }
}

/*
 * mdlInitializeSampleTimes - initializes the array of sample times stored in
 *                            the SimStruct associated with this S-Function.
 */

static void mdlInitializeSampleTimes(SimStruct *S)
{
    /*
     * Note, blocks that are continuous in nature should have a single
     * sample time of 0.0.
     */

    ssSetSampleTimeEvent(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTimeEvent(S, 0, 0.0);
}

/*
 * mdlInitializeConditions - initializes the states for the S-Function
 */

static void mdlInitializeConditions(real_T *x0, SimStruct *S)
{

    int_T    *Index          = ssGetIWork(S);
    int_T    *lastTrig       = ssGetIWork(S) + 1;    

    *Index          = 0;
    *lastTrig       = 0;
}

/*
 * mdlOutputs - computes the outputs of the S-Function
 */

static void mdlOutputs(real_T *y, const real_T *x, const real_T *u, SimStruct *S, int_T tid)
{
  if (ssIsMajorTimeStep(S)) {
    int_T    *Index          = ssGetIWork(S);
    int_T    *lastTrig       = ssGetIWork(S) + 1;    

    int_T     numOutput      = mxGetN(VARIABLE);
    int_T     maxBuffer      = mxGetM(VARIABLE);
    int_T     cyclFlag       = (int_T)mxGetPr(CYCL_FLAG)[0];
    real_T  thd            = mxGetPr(THRESHOLD)[0];
    
    int_T     i, outIndex;
    
    ssSetSolverNeedsReset(S);

    if ((u[0] >= thd) & (*lastTrig == 0)) {
        outIndex = *Index;
        *Index += 1;
        if (cyclFlag != 0)
            outIndex %= maxBuffer;
	
        if (outIndex < maxBuffer) {
            for (i = 0; i < numOutput; i++)
                y[i] = mxGetPr(VARIABLE)[outIndex + i * maxBuffer];
        } else {
            for (i = 0; i < numOutput; i++)
                y[i] = 0.0;            
        }
        *lastTrig = 1;
    } else {
	if (ssGetT(S) <= 0.0) {
      if ((mxGetN(INIOUTPUT) * mxGetM(INIOUTPUT)) == numOutput) {
		for (i = 0; i < numOutput; i++)
		    y[i] = mxGetPr(INIOUTPUT)[i];
	    } else if ((mxGetN(INIOUTPUT) * mxGetM(INIOUTPUT)) <= 0) {
		for (i = 0; i < numOutput; i++)
		    y[i] = 0.0;
	  } else {
		for (i = 0; i < numOutput; i++)
		    y[i] = mxGetPr(INIOUTPUT)[0];
	    }	
	}
	if (*lastTrig == 1) {
	    if (u[0] < thd)
		*lastTrig = 0;
	}
      }
  }
}

/*
 * mdlUpdate - computes the discrete states of the S-Function
 */

static void mdlUpdate(real_T *x, const real_T *u, SimStruct *S, int_T tid)
{
}

/*
 * mdlDerivatives - computes the derivatives of the S-Function
 */

static void mdlDerivatives(real_T *dx, const real_T *x, const real_T *u, SimStruct *S, int_T tid)
{
}

/*
 * mdlTerminate - called at termination of model execution.
 */

static void mdlTerminate(SimStruct *S)
{
}

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-File interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
