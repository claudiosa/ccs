def get_tail(l):
    l_new = []
    size = len(l)
    i=0
    while (i < size):
        l_new.append(l[i])
        i=i+1
    # print (l_new)
    return(l_new)


def main():
    print("Hello world")
    lst = ['headerXXXX','bodyYYYYY','tailZZZZ']
    header = lst.pop(0)
    print('HEADER:',  header )
    print('TAIL:',  get_tail( lst ) )
    
if __name__ == "__main__":
    main()
    print("OUT of MAIN class")
