# Rosetta in Docker

Run [Rosetta](https://github.com/LatticeX-Foundation/Rosetta) in Docker.

## Usage

1. Build container

   ```
   docker-compose up -d
   ```

2. Run container

   ```
   docker exec -it rosetta /usr/bin/fish
   cd /workspace/Rosseta
   ```

## Reproduce of `memory corruption` error

1. build the docker
2. run the `rtt-linear_regression.py` example in tutorials

   ```
   cd /workspace/Rosetta/example/tutorials/code
   ./tutorials.sh rtt logistic_regression
   ```

Backtrace:

```
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007f7b379bd7f1 in __GI_abort () at abort.c:79
#2  0x00007f7b37a06837 in __libc_message (action=action@entry=do_abort, fmt=fmt@entry=0x7f7b37b33a7b "%s\n") at ../sysdeps/posix/libc_fatal.c:181
#3  0x00007f7b37a0d8ba in malloc_printerr (str=str@entry=0x7f7b37b31c76 "free(): invalid pointer") at malloc.c:5342
#4  0x00007f7b37a14dec in _int_free (have_lock=0, p=0x7f79540a7fc0, av=0x7f7b37d68c40 <main_arena>) at malloc.c:4167
#5  __GI___libc_free (mem=0x7f79540a7fd0) at malloc.c:3134
#6  0x00007f7a6fc97a9c in rosetta::snn::SnnInternal::Sigmoid5PieceWise(std::vector<unsigned long, std::allocator<unsigned long> > const&, std::vector<unsigned long, std::allocator<unsigned long> >&) () from /usr/local/lib/python3.6/dist-packages/latticex/libmpc-snn.so
#7  0x00007f7a6fc073a8 in rosetta::snn::SnnProtocolOps::Sigmoid(std::vector<std::string, std::allocator<std::string> > const&, std::vector<std::string, std::allocator<std::string> >&, std::unordered_map<std::string, std::string, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::string> > > const*) () from /usr/local/lib/python3.6/dist-packages/latticex/libmpc-snn.so
#8  0x00007f7a6e7ce22d in tensorflow::SecureSigmoidOp::UnaryCompute(std::vector<std::string, std::allocator<std::string> > const&, std::vector<std::string, std::allocator<std::string> >&, tensorflow::OpKernelContext*) () from /usr/local/lib/python3.6/dist-packages/latticex/rosetta/secure/decorator/../../../libsecure-ops.so
#9  0x00007f7a6e7574b4 in tensorflow::SecureUnaryOp::ComputeImpl(tensorflow::OpKernelContext*) ()
   from /usr/local/lib/python3.6/dist-packages/latticex/rosetta/secure/decorator/../../../libsecure-ops.so
#10 0x00007f7a6e7480a3 in tensorflow::SecureOpKernel::Compute(tensorflow::OpKernelContext*) ()
   from /usr/local/lib/python3.6/dist-packages/latticex/rosetta/secure/decorator/../../../libsecure-ops.so
#11 0x00007f7aa4b3dd94 in tensorflow::(anonymous namespace)::ExecutorState::Process(tensorflow::(anonymous namespace)::ExecutorState::TaggedNode, long long) ()
   from /usr/local/lib/python3.6/dist-packages/tensorflow/python/../libtensorflow_framework.so.1
#12 0x00007f7aa4b30050 in std::_Function_handler<void (), std::_Bind<std::_Mem_fn<void (tensorflow::(anonymous namespace)::ExecutorState::*)(tensorflow::(anonymous namespace)::ExecutorState::TaggedNode, long long)> (tensorflow::(anonymous namespace)::ExecutorState*, tensorflow::(anonymous namespace)::ExecutorState::TaggedNode, long long)> >::_M_invoke(std::_Any_data const&) () from /usr/local/lib/python3.6/dist-packages/tensorflow/python/../libtensorflow_framework.so.1
#13 0x00007f7aa4bdb6d4 in Eigen::ThreadPoolTempl<tensorflow::thread::EigenEnvironment>::WorkerLoop(int) ()
   from /usr/local/lib/python3.6/dist-packages/tensorflow/python/../libtensorflow_framework.so.1
#14 0x00007f7aa4bda544 in std::_Function_handler<void (), tensorflow::thread::EigenEnvironment::CreateThread(std::function<void ()>)::{lambda()#1}>::_M_invoke(std::_Any_data const&) () from /usr/local/lib/python3.6/dist-packages/tensorflow/python/../libtensorflow_framework.so.1
#15 0x00007f7aa375ea50 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#16 0x00007f7b377656db in start_thread (arg=0x7f7963fff700) at pthread_create.c:463
#17 0x00007f7b37a9e61f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
```
