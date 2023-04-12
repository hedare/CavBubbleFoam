Info<< "Reading field p_rgh\n" << endl;
volScalarField p_rgh
(
    IOobject
    (
        "p_rgh",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);
/*
volVectorField gradp
(
    IOobject
    (
        "gradp",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::AUTO_WRITE
    ),
    fvc::grad(p_rgh)
);
gradp.write();
*/
volScalarField p_g
(
    IOobject
    (
        "p_rgh",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::NO_WRITE
    ),
    p_rgh
);

Info<< "Reading field U\n" << endl;
volVectorField U
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

volVectorField inkMap
(
    IOobject
    (
        "inkMap",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

#include "createPhi.H"

Info<< "Constructing twoPhaseMixtureThermo\n" << endl;
twoPhaseMixtureThermo mixture(mesh);

volScalarField& alpha1(mixture.alpha1());
volScalarField& alpha2(mixture.alpha2());

Info<< "Reading thermophysical properties\n" << endl;

volScalarField& rho1 = mixture.thermo1().rho();
volScalarField& rho2 = mixture.thermo2().rho();

volScalarField rho
(
    IOobject
    (
        "rho",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    alpha1*rho1 + alpha2*rho2
);


dimensionedScalar pMin
(
    "pMin",
    dimPressure,
    mixture
);

mesh.setFluxRequired(p_rgh.name());


#include "readGravitationalAcceleration.H"
#include "readhRef.H"
#include "gh.H"


// Mass flux
// Initialisation does not matter because rhoPhi is reset after the
// alpha1 solution before it is used in the U equation.
surfaceScalarField rhoPhi
(
    IOobject
    (
        "rhoPhi",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::NO_WRITE
    ),
    fvc::interpolate(rho)*phi
);

volScalarField dgdt
(
    pos(alpha2)*fvc::div(phi)/max(alpha2, scalar(0.0001))
);

// Construct interface from alpha1 distribution
interfaceProperties interface(alpha1, U, mixture);

// Construct compressible turbulence model
autoPtr<compressible::turbulenceModel> turbulence
(
    compressible::turbulenceModel::New(rho, U, rhoPhi, mixture)
);

Info<< "Creating field kinetic energy K\n" << endl;
volScalarField K("K", 0.5*magSqr(U));

dimensionedScalar epsPsi("epsPsi", dimensionSet (0, -2, 2, 0, 0, 0, 0), 1e-18);

Info<< "Reading transportProperties\n" << endl;

IOdictionary transportProperties
(
    IOobject
    (
        "transportProperties",
        runTime.constant(),
        mesh,
        IOobject::MUST_READ_IF_MODIFIED,
        IOobject::NO_WRITE
    )
);

bool correctBubbleMass = mesh.solutionDict().subDict("PIMPLE").lookupOrDefault<Switch>("correctBubbleMass",false);
scalar limitAlpha(mesh.solutionDict().subDict("PIMPLE").lookupOrDefault<scalar>("limitAlpha", 0.0));
dimensionedScalar pfact(transportProperties.lookup("pfact"));

IOdictionary thermophysicalProperties_air
(
    IOobject
    (
        "thermophysicalProperties.air",
        runTime.constant(),
        mesh,
        IOobject::MUST_READ_IF_MODIFIED,
        IOobject::NO_WRITE
    )
);

dimensionedScalar B_air     ("B",     dimPressure, thermophysicalProperties_air.subDict("mixture").subDict("equationOfState"));
dimensionedScalar rho0_air  ("rho0",  dimDensity,  thermophysicalProperties_air.subDict("mixture").subDict("equationOfState"));
dimensionedScalar p0_air    ("p0",    dimPressure, thermophysicalProperties_air.subDict("mixture").subDict("equationOfState"));
dimensionedScalar gamma_air ("gamma", dimless,     thermophysicalProperties_air.subDict("mixture").subDict("equationOfState"));

const word kinematicCloudName("kinematicCloud");

volScalarField mu
(
    IOobject
    (
        "mu",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::NO_WRITE
    ),
    mixture.nu()*rho
);

Info << "Constructing kinematicCloud " << kinematicCloudName << endl;
basicKinematicCloud kinematicCloud
(
    kinematicCloudName,
    rho,
    U,
    mu,
    g
);
