if (correctBubbleMass)
{
    bubblem = Foam::gSum(mesh.V()*alpha2rho.field());
    bubbleV = Foam::gSum(mesh.V()*alpha2.field());
    rho2 = rho2 * bubblem0 / bubblem;
    if (bubblePhase == 0)
    {
        if (bubbleV < bubbleV0 && runTime.value() > 1e-6)
        {
            bubblePhase = 1;
            rho2 = rho2 * pfact;
            alpha2rho = alpha2*rho2;
	    bubblem0 = Foam::gSum(mesh.V()*alpha2rho.field());
        }
        bubbleV0 = bubbleV;
    }
    p_g = max((p0_air + B_air) * pow(rho2/rho0_air , gamma_air ) - B_air,pMin);
    p_rgh = alpha1 * p_rgh + alpha2 * p_g;
    p = max(p_rgh + (alpha1*rho1 + alpha2*rho2)*gh, pMin);
    mixture.correct();
}
