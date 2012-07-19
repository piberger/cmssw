#
# FFTJet dijet analyzer configuration
#
# I. Volobouev, July 19, 2012
#
import math
import FWCore.ParameterSet.Config as cms

fftjetDijetMatch = cms.EDAnalyzer(
    "FFTJetDijetMatch",
    #
    # Which info we are going to collect?
    collectCaloJets = cms.bool(False),
    collectPFJets = cms.bool(True),
    #
    # Labels for jet collections and FFTJetProducer summaries
    genjetCollectionLabel = cms.InputTag("fftjetproducer", "MadeByFFTJet"),
    caloCollectionLabel = cms.InputTag("fftjetproducer", "MadeByFFTJet"),
    pfCollectionLabel = cms.InputTag("fftjetproducer", "MadeByFFTJet"),
    #
    # Ntuple names and titles. Should be unique for the whole job.
    caloTitle = cms.string("FFT_Dijet_Calo"),
    pfTitle = cms.string("FFT_Dijet_PF"),
    #
    # Conversion factor from scale squared times peak magnitude to Pt.
    # Note that this factor depends on the grid used for pattern resolution.
    # The default value given here is correct for the default grid only.
    ptConversionFactor = cms.double(128*256/(4.0*math.pi)),
    #
    # Subtract pileup as 4-vector?
    subtractPileupAs4Vec = cms.bool(False)
)
