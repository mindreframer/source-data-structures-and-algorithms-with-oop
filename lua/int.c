/*
    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 01:56:00 $
    $RCSfile: int.c,v $
    $Revision: 1.8 $
*/

#include <stdio.h>
#include <math.h>
#include <limits.h>
#include "lua.h"
#include "lauxlib.h"

static char const* const __attribute__((unused)) rcsid =
    "@(#) $Id: int.c,v 1.8 2004/11/27 01:56:00 brpreiss Exp $";
static char const* const __attribute__((unused)) copyright =
    "@(#) Copyright (c) 2004 by Bruno R. Preiss, P.Eng.";

/**
 * Userdata type name
 */
static char const* const OPUS9_INT = "Opus9.int";

/**
 * Checks that the item at the specified index in the Lua interpreter stack
 * is of type userdata with with the Opus9.int metatable.
 * Returns a pointer to that int.
 *
 * @param L Lua interpreter state.
 * @param index Lua stack index.
 */
static int* int_checktype(lua_State* L, int index)
{
    void* ud = NULL;

    ud = luaL_checkudata(L, index, OPUS9_INT);
    luaL_argcheck(L, ud != NULL, 1, "'int' expected");
    return (int*) ud;
}

/**
 * Pushes an Opus9.int with the given value onto the Lua interpreter stack.
 *
 * @param L Lua interpreter state.
 * @param value A value.
 */
static void int_push(lua_State* L, int value)
{
    int* result = NULL;

    result = (int*)lua_newuserdata(L, sizeof(int));
    luaL_getmetatable(L, OPUS9_INT);
    lua_setmetatable(L, -2);
    *result = (int)value;
}

/**
 * Pushes a new Opus9.int with the given value onto the Lua interpreter stack.
 *
 * @param L Lua interpreter state.
 */
static int int_new(lua_State* L)
{
    int value = 0;

    value = luaL_checkint(L, 1);
    int_push(L, (int)value);
    return 1;
}

/**
 * Compares the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_cmp(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    lua_pushnumber(L, *arg1 - *arg2);
    return 1;
}

/**
 * Returns the sum of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_add(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 + *arg2);
    return 1;
}

/**
 * Returns the difference of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_sub(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 - *arg2);
    return 1;
}

/**
 * Returns the product of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_mul(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 * *arg2);
    return 1;
}

/**
 * Returns the quotient of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_div(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 / *arg2);
    return 1;
}

/**
 * Returns the remainder of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_mod(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 % *arg2);
    return 1;
}

/**
 * Returns the negation of the given int.
 *
 * @param L Lua interpreter state.
 */
static int int_unm(lua_State* L)
{
    int* arg1 = NULL;

    arg1 = int_checktype(L, 1);
    int_push(L, -*arg1);
    return 1;
}

/**
 * Returns the first int raised to the power of the second int.
 *
 * @param L Lua interpreter state.
 */
static int int_pow(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, (int)pow((double)*arg1, (double)*arg2));
    return 1;
}

/**
 * Returns the bitwise and of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_AND(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 & *arg2);
    return 1;
}

/**
 * Returns the bitwise or of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_OR(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 | *arg2);
    return 1;
}

/**
 * Returns the bitwise xor of the given ints.
 *
 * @param L Lua interpreter state.
 */
static int int_XOR(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 ^ *arg2);
    return 1;
}

/**
 * Returns the bitwise complement of the given int.
 *
 * @param L Lua interpreter state.
 */
static int int_NOT(lua_State* L)
{
    int* arg1 = NULL;

    arg1 = int_checktype(L, 1);
    int_push(L, ~*arg1);
    return 1;
}

/**
 * Returns the first int shifted left
 * by the number bits given by the second int.
 *
 * @param L Lua interpreter state.
 */
static int int_lshift(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 << *arg2);
    return 1;
}

/**
 * Returns the first int shifted left
 * by the number bits given by the second int.
 *
 * @param L Lua interpreter state.
 */
static int int_rshift(lua_State* L)
{
    int* arg1 = NULL;
    int* arg2 = NULL;

    arg1 = int_checktype(L, 1);
    arg2 = int_checktype(L, 2);
    int_push(L, *arg1 >> *arg2);
    return 1;
}

/**
 * Returns a string representation of an int.
 *
 * @param L Lua interpreter state.
 */
static int int_tostring(lua_State* L)
{
    char buf[16];
    int* arg1;

    arg1 = int_checktype(L, 1);
    snprintf(buf, 16, "%d", *arg1);
    lua_pushstring(L, buf);
    return 1;
}

/**
 * Returns a number representation of an int.
 *
 * @param L Lua interprester state.
 */
static int int_tonumber(lua_State* L)
{
    int* arg1 = NULL;

    arg1 = int_checktype(L, 1);
    lua_pushnumber(L, *arg1);
    return 1;
}

/**
 * Opus9.int library functions table.
 */
static struct luaL_reg const int_f[] =
{
    { "new",	int_new },
    { NULL,	NULL}
};

/**
 * Opus9.int library methods table.
 */
static struct luaL_reg const int_m[] =
{
    { "cmp",	int_cmp },
    { "add",	int_add },
    { "sub",	int_sub },
    { "mul",	int_mul },
    { "div",	int_div },
    { "mod",	int_mod },
    { "unm",	int_unm },
    { "pow",	int_pow },
    { "AND",	int_AND },
    { "OR",	int_OR },
    { "XOR",	int_XOR },
    { "NOT",	int_NOT },
    { "lshift",	int_lshift },
    { "rshift",	int_rshift },
    { "__tostring", int_tostring },
    { "__tonumber", int_tonumber },
    { NULL,	NULL}
};

/**
 * Constants table entry.
 */
struct int_constant
{
    char const* const name;
    int const value;
};

/**
 * Opus9.int constants table.
 */
static struct int_constant const int_constants[] =
{
    { "MAX",	INT_MAX },
    { "MIN",	INT_MIN },
    { "BITS",	8*sizeof(int) },
    { NULL,	0 }
};

/**
 * Defines the Opus9.int constants.
 * 
 * @param L Lua interpreter state.
 */
static void int_defconstants(lua_State* L)
{
    int i = 0;

    lua_getglobal(L, "int");
    if (!lua_istable(L, -1))
    {
	luaL_error(L, "'int' is not a table");
    }

    for (i = 0; int_constants[i].name != NULL; ++i)
    {
	lua_pushstring(L, int_constants[i].name);
	int_push(L, int_constants[i].value);
	lua_settable(L, -3);
    }

    lua_pop(L, -1);
}

/**
 * Opus9.int library entry point.
 *
 * @param L Lua interpreter state.
 */
extern int luaopen_int(lua_State* L)
{
    /* Create Opus9.int metatable. */
    luaL_newmetatable(L, OPUS9_INT);

    /* metatable.__index = metatable */
    lua_pushstring(L, "__index");
    lua_pushvalue(L, -2);
    lua_settable(L, -3);

    /* Enter methods into metatable. */
    luaL_openlib(L, NULL, int_m, 0);

    luaL_openlib(L, "int", int_f, 0);

    /* Pop metatable. */
    lua_pop(L, -1);

    /* Define constants. */
    int_defconstants(L);

    return 1;
}
