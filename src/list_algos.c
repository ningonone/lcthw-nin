#include "list_algos.h"
#include "dbg.h"

inline void ListNode_swap(ListNode *a, ListNode *b)
{
    void *temp = a->value;
    a->value = b->value;
    b->value = temp;
}


/* 冒泡算法 */
int List_bubble_sort(List *list, List_compare cmp) 
{
    int sorted = 1;

    if(List_count(list) <= 1 ) {
        return 0;
    }

    do {
        sorted = 1;
        LIST_FOREACH(list, first, next, cur) {
            if (cur->next) {
                if(cmp(cur->value, cur->next->value) > 0) {
                    ListNode_swap(cur, cur->next);
                    sorted = 0;
                }
            }
        }
    } while(!sorted);

    return 0;
}

/***
 *  Todo : 归并排序，稍微有点复杂，暂时懒得看了。
 */





