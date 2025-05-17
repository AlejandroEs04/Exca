import { ChangeEvent } from "react";

type StateSetter<T> = React.Dispatch<React.SetStateAction<T>>;

export const handleFormChange = <T extends object>(
    e: ChangeEvent<HTMLElement>,
    state: T,
    setState: StateSetter<T>
) => {
    const target = e.target as HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement;
    const { name, type } = target;

    const value =
        type === "checkbox"
            ? (target as HTMLInputElement).checked
            : target.value;

    if (name.includes('.')) {
        const [parentProp, childProp] = name.split('.');

        setState(prev => {
            if (parentProp in prev && typeof prev[parentProp as keyof T] === 'object') {
                return {
                    ...prev,
                    [parentProp]: {
                        ...(prev[parentProp as keyof T] as object),
                        [childProp]: value
                    }
                };
            }
            return prev;
        });

    } else {
        setState({
            ...state,
            [name]: value
        });
    }
};