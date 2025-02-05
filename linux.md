# Tools
## nvim
* configuration : https://builtin.com/software-engineering-perspectives/neovim-configuration

## lsd
Use fira (nerd font) to display icons
## prettify
[mark down icons](https://github.com/ikatyang/emoji-cheat-sheet?tab=readme-ov-file)

## prog

### HTTP

* jq Basics

### GO

* GO: interface , defer, concurrency
* [concurrency in go](https://www.boot.dev/lessons/ae21fb67-6443-4b43-b569-14b452872311)
* anonymous function , [channels](https://www.boot.dev/lessons/04984711-09c4-4020-ac36-6d4214012d34)
* channels
    ``ch := make(chan int)`` OR ``ch := make(chan int, 100)`` for buffer length
    `close(ch)` to close it
    `v, ok := <- ch` : ok is false if channel is empty and closed
    `ch <- 69` (will block)
    `<- 69` (use block and wait)
    `v := <-ch` OR `for v := range ch {}` : exit when closed
    ``select {
        case i, ok := <- chInts: OR case <- chInts if i, ok not needed
            fmt.Println(i)
        case s, ok := <- chStrings:
            fmt.Println(s)
        }``
    use default for nonblocking
    cast for read only `func readCh(ch <-chan int) {}`
    cast for write only `func readCh(ch chan<- int) {}`
* tickers
** time.Tick(), time.After(), time.Sleep()
** time.Tick(500 * time.Millisecond)
* Mutex [bootdev](https://www.boot.dev/lessons/720b45b3-4d5f-421c-afd7-30718166fbd4)
** `sync.RWMutex` : RLOCK(), RUnlock()
* Generics [bootdev](https://www.boot.dev/lessons/c8999752-768a-401b-b881-602929927699)
** constraint : `func concat[T stringer](vals []T) string {}`
** `type Ordered interface { ~int | ... | ~string }
** `type store[P product] interface { Sell(P) }
