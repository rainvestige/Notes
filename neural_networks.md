# NEURAL NETWORKS

## CNN

## RNN(Recurrent Neural Networks)
>1. Long Short-Term Memory(LSTM)
>   The LSTM is a particular type of recurrent network that works slightly
>   better in parctice.

### Ref
> [rnn-effectiveness](https://karpathy.github.io/2015/05/21/rnn-effectiveness/)

### Sequence
The core reason that recurrent nets are more exciting is that they allow us 
to operate over sequences of vectors: Sequences in the input, the output, or 
in the most general case both. A few examples may make this more 
concrete:
![sequence example](https://karpathy.github.io/assets/rnn/diags.jpeg)
Each rectangle is a vector and arrows represent functions (e.g. matrix 
multiply). Input vectors are in red, output vectors are in blue and green 
vectors hold the RNN's state (more on this soon). From left to right: 

 (1) Vanilla mode of processing without RNN, from fixed-sized input to fixed-sized 
output (e.g. image classification).<br>
 (2) Sequence output (e.g. image captioning takes an image and outputs a sentence of words).<br>
 (3) Sequence input (e.g. sentiment analysis where a given sentence is classified as 
expressing positive or negative sentiment).<br>
 (4) Sequence input and sequence output (e.g. Machine Translation: an RNN reads 
a sentence in English and then outputs a sentence in French).<br>
 (5) Synced sequence input and output (e.g.  video classification where we wish 
to label each frame of the video). Notice that in every case are no pre-specified 
constraints on the lengths sequences because the recurrent transformation (green) 
is fixed and can be applied as many times as we like.

### Sequential processing in absence of sequences
You might be thinking that having sequences as inputs or outputs could be 
relatively rare, but an important point to realize is that even if your 
inputs/outputs are fixed vectors, it is still possible to use this powerful 
formalism to process them in a sequential manner.

### RNN computation
However, crucially this output vector’s contents are influenced not only by 
the input you just fed in, but also on the entire history of inputs you’ve 
fed in in the past.
