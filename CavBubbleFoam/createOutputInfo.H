// fields to write output-bubble information

    volScalarField alpha2p = alpha2*p;
    volScalarField alpha2rho = alpha2*rho;
    scalar bubblem0 = Foam::gSum(mesh.V()*alpha2rho.field());
    scalar bubblem = 0;
    scalar bubbleV0 = Foam::gSum(mesh.V()*alpha2.field());
    scalar bubbleV = 0;
    int bubblePhase = 0;

    ofstream infovstime;
    
    infovstime.open ("info.csv", ios::out|ios::trunc);
    //               1        2             3            4
    infovstime << "%Time,bubbleVolume,bubblepressure,bubblemass" << nl;
    infovstime << runTime.timeName() << ","
               << bubbleV0 << ","
               << Foam::gSum(mesh.V()*alpha2p.field())/bubbleV0 << ","
               << bubblem0 << nl;
               
    infovstime.flush();
